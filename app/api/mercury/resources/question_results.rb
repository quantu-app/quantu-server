# frozen_string_literal: true

module Mercury
  module Resources
    class QuestionResults < API
      namespace :question_results do
        before { authenticate! }
        after { verify_authorized }

        desc 'List all question results for a given question',
             is_array: true,
             success: { code: 200, model: Mercury::Entities::QuestionResult },
             failure: [
               { code: 401, model: Mercury::Entities::ErrorResponse },
               { code: 404, model: Mercury::Entities::ErrorResponse }
             ]
        params do
          requires :question_id, type: Integer, desc: 'Question ID', allow_blank: false,
                                 documentation: { param_type: 'body' }
        end
        get do
          authorize(::QuestionResult, :index?)
          @question = current_user.questions.find(params[:question_id])
          @question_results = @question.question_results.all
          present(@question_results, with: Mercury::Entities::QuestionResult)
        end

        desc 'Create a new question result',
             success: { code: 201, model: Mercury::Entities::QuestionResult },
             failure: [
               { code: 401, model: Mercury::Entities::ErrorResponse },
               { code: 404, model: Mercury::Entities::ErrorResponse },
               { code: 422, model: Mercury::Entities::ErrorResponse }
             ]
        params do
          requires :question_id, type: Integer, desc: 'Question ID', allow_blank: false,
                                 documentation: { param_type: 'body' }
          optional :study_session_id, type: Integer, desc: 'Learning Session ID'
          requires :data, type: JSON, documentation: { param_type: 'body' }
        end
        post do
          authorize(::QuestionResult, :create?)
          @question = current_user.questions.find(params[:question_id])
          @study_session = current_user.study_sessions.find(params[:study_session_id]) if params[:study_session_id]
          @question_result = @question.question_results.new(
            user: current_user,
            study_session: @study_session,
            data: params[:data]
          )

          if @question_result.save
            present(@question_result, with: Mercury::Entities::QuestionResult, status: 201)
          else
            error!({ errors: @question_result.errors.full_messages }, 422)
          end
        end

        desc 'Show a single question result',
             success: { code: 200, model: Mercury::Entities::QuestionResult },
             failure: [
               { code: 401, model: Mercury::Entities::ErrorResponse },
               { code: 404, model: Mercury::Entities::ErrorResponse }
             ]
        params do
          requires :question_id, type: Integer, desc: 'Question ID', allow_blank: false,
                                 documentation: { param_type: 'body' }
          requires :id, type: Integer
        end
        get ':id' do
          @question = current_user.questions.find(params[:question_id])
          @question_result = @question.question_results.find(params[:id])
          authorize(@question_result, :show?)
          present(@question_result, with: Mercury::Entities::QuestionResult)
        end

        desc 'Delete a question result',
             success: { code: 200 },
             failure: [
               { code: 401, model: Mercury::Entities::ErrorResponse },
               { code: 404, model: Mercury::Entities::ErrorResponse }
             ]
        params do
          requires :question_id, type: Integer, desc: 'Question ID', allow_blank: false,
                                 documentation: { param_type: 'body' }
          requires :id, type: Integer
        end
        delete ':id' do
          @question = current_user.questions.find(params[:question_id])
          @question_result = @question.question_results.find(params[:id])
          authorize(@question_result, :destroy?)
          @question_result.destroy
          body false
        end

        desc 'Delete all the question results for a given question',
             success: { code: 200 },
             failure: [
               { code: 401, model: Mercury::Entities::ErrorResponse },
               { code: 404, model: Mercury::Entities::ErrorResponse }
             ]
        params do
          requires :question_id, type: Integer, desc: 'Question ID', allow_blank: false,
                                 documentation: { param_type: 'body' }
          requires :id, type: Integer
        end
        delete do
          @question = current_user.questions.find(params[:question_id])
          authorize(QuestionResult, :destroy_all?)
          @question.question_results.destroy_all
          body false
        end
      end
    end
  end
end
