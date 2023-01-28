# frozen_string_literal: true

module Mercury
  module Resources
    class Quizzes < API
      namespace :quizzes do
        before { authenticate! }
        after { verify_authorized }

        desc 'List all quizzes',
             is_array: true,
             success: { code: 200, model: Mercury::Entities::Quiz },
             failure: [
               { code: 401, model: Mercury::Entities::ErrorResponse }
             ]
        get do
          authorize(::Quiz, :index?)
          @quizzes = current_user.quizzes.all
          present(@quizzes, with: Mercury::Entities::Quiz)
        end

        desc 'Create a new quiz',
             success: { code: 201, model: Mercury::Entities::Quiz },
             failure: [
               { code: 401, model: Mercury::Entities::ErrorResponse },
               { code: 422, model: Mercury::Entities::ErrorResponse }
             ]
        params do
          requires :name, type: String, desc: 'Name', allow_blank: false, documentation: { param_type: 'body' }
        end
        post do
          authorize(::Quiz, :create?)
          @quiz = current_user.quizzes.new(name: params[:name])

          if @quiz.save
            present(@quiz, with: Mercury::Entities::Quiz, status: 201)
          else
            error!({ errors: @quiz.errors.full_messages }, 422)
          end
        end

        desc 'Show a quiz',
             success: { code: 200, model: Mercury::Entities::Quiz },
             failure: [
               { code: 401, model: Mercury::Entities::ErrorResponse },
               { code: 404, model: Mercury::Entities::ErrorResponse }
             ]
        params do
          requires :id, type: Integer
        end
        get ':id' do
          @quiz = Quiz.find(params[:id])
          authorize(@quiz, :show?)
          present(@quiz, with: Mercury::Entities::Quiz)
        end

        desc 'Update a quiz',
             success: { code: 200, model: Mercury::Entities::Quiz },
             failure: [
               { code: 401, model: Mercury::Entities::ErrorResponse },
               { code: 404, model: Mercury::Entities::ErrorResponse }
             ]
        params do
          requires :id, type: Integer
          optional :name, type: String, desc: 'Name', allow_blank: false, documentation: { param_type: 'body' }
        end
        patch ':id' do
          @quiz = Quiz.find(params[:id])
          authorize(@quiz, :update?)
          if @quiz.update(params.except(:id))
            present(@quiz, with: Mercury::Entities::Quiz)
          else
            error!({ errors: @quiz.errors.full_messages }, 422)
          end
        end

        desc 'Delete a quiz',
             success: { code: 200 },
             failure: [
               { code: 401, model: Mercury::Entities::ErrorResponse },
               { code: 404, model: Mercury::Entities::ErrorResponse }
             ]
        params do
          requires :id, type: Integer
        end
        delete ':id' do
          @quiz = Quiz.find(params[:id])
          authorize(@quiz, :destroy?)
          @quiz.destroy
          body false
        end
      end
    end
  end
end
