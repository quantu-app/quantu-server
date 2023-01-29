# frozen_string_literal: true

module Mercury
  module Resources
    class StudySessions < API
      namespace :study_sessions do
        before { authenticate! }
        after { verify_authorized }

        desc 'List all study sessions for a given user',
             is_array: true,
             success: { code: 200, model: Mercury::Entities::StudySession },
             failure: [
               { code: 401, model: Mercury::Entities::ErrorResponse },
               { code: 404, model: Mercury::Entities::ErrorResponse }
             ]
        get do
          authorize(::StudySession, :index?)
          @study_sessions = current_user.study_sessions.includes([:learnable_resource]).all
          present(@study_sessions, with: Mercury::Entities::StudySession)
        end

        desc 'Create a new study session',
             success: { code: 201, model: Mercury::Entities::StudySession },
             failure: [
               { code: 401, model: Mercury::Entities::ErrorResponse },
               { code: 404, model: Mercury::Entities::ErrorResponse },
               { code: 422, model: Mercury::Entities::ErrorResponse }
             ]
        params do
          requires :learnable_id, type: Integer, desc: 'Learnable ID', documentation: {
            type: 'Integer',
            desc: 'Learnable ID',
            param_type: 'body',
            required: true
          }
          requires :learnable_type, type: String, desc: 'Learnable Type', values: %w[Quiz]
          optional :data, type: JSON, documentation: { type: 'object' }
        end
        post do
          authorize(::StudySession, :create?)
          @learnable_resource = current_user.learnable_resources.find_by!(
            learnable_id: params[:learnable_id],
            learnable_type: params[:learnable_type]
          )
          @study_session = current_user.study_sessions.new(
            user: current_user,
            learnable_resource: @learnable_resource,
            data: params[:data]
          )

          if @study_session.save
            present(@study_session, with: Mercury::Entities::StudySession, status: 201)
          else
            error!({ errors: @study_session.errors.full_messages }, 422)
          end
        end

        desc 'Show a single study session',
             success: { code: 200, model: Mercury::Entities::StudySession },
             failure: [
               { code: 401, model: Mercury::Entities::ErrorResponse },
               { code: 404, model: Mercury::Entities::ErrorResponse }
             ]
        params do
          requires :id, type: Integer
        end
        get ':id' do
          @study_session = current_user.study_sessions.find(params[:id])
          authorize(@study_session, :show?)
          present(@study_session, with: Mercury::Entities::StudySession)
        end

        desc 'Update a Study Session',
             success: { code: 200, model: Mercury::Entities::StudySession },
             failure: [
               { code: 401, model: Mercury::Entities::ErrorResponse },
               { code: 404, model: Mercury::Entities::ErrorResponse },
               { code: 422, model: Mercury::Entities::ErrorResponse }
             ]
        params do
          requires :id, type: Integer
          optional :data, type: JSON, allow_blank: false,
                          documentation: {
                            type: 'object',
                            param_type: 'body'
                          }
        end
        patch ':id' do
          @study_session = current_user.study_sessions.find(params[:id])
          authorize(@study_session, :update?)
          if @study_session.update(params.except(:id))
            present(@study_session, with: Mercury::Entities::StudySession)
          else
            error!({ errors: @study_session.errors.full_messages }, 422)
          end
        end

        desc 'Delete a study session',
             success: { code: 200 },
             failure: [
               { code: 401, model: Mercury::Entities::ErrorResponse },
               { code: 404, model: Mercury::Entities::ErrorResponse }
             ]
        params do
          requires :id, type: Integer
        end
        delete ':id' do
          @study_session = current_user.study_sessions.find(params[:id])
          authorize(@study_session, :destroy?)
          @study_session.destroy
          body false
        end
      end
    end
  end
end
