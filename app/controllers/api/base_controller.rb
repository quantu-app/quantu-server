# frozen_string_literal: true

module Api
  class BaseController < ApplicationController

    include Pundit::Authorization

    # actions
    skip_before_action :verify_authenticity_token
    before_action :authorize_request
    before_action :ensure_json_request

    # helper methods
    attr_reader :current_user

    # error handlers
    rescue_from(ActionController::UnpermittedParameters) do |exception|
      render json: { error: { unknown_parameters: exception.params } }, status: :bad_request
    end

    rescue_from(ActionController::ParameterMissing) do |exception|
      render json: { error: { missing_parameter: exception.param } }, status: :bad_request
    end

    rescue_from(Pundit::NotAuthorizedError) do |exception|
      policy_name = exception.policy.class.to_s.underscore
      message = I18n.t("#{policy_name}.#{exception.query}", scope: "pundit", default: :default)
      render json: { error: message }, status: :unauthorized
    end

    rescue_from(ActiveRecord::RecordNotFound) do |_exception|
      render json: { error: "resource not found"}, status: :not_found
    end

    rescue_from(ActionDispatch::Http::Parameters::ParseError) do |exception|
      render json: { error: exception.message }, status: :bad_request
    end

    def authorize_request
      header = request.headers['Authorization']
      header = header.split(' ').last if header
      begin
        @decoded = QuantU::Utils::JsonWebToken.decode(header)
        @current_user = User.find(@decoded[:user_id])
      rescue ActiveRecord::RecordNotFound => e
        render json: { errors: e.message }, status: :unauthorized
      rescue JWT::DecodeError => e
        render json: { errors: e.message }, status: :unauthorized
      end
    end

    def ensure_json_request
      if request.headers['Content-Type'] == 'application/json'
        request.format = :json
      else
        render json: { errors: '`Content-Type` must be application/json'}, status: :not_acceptable
      end  
    end
  end
end
