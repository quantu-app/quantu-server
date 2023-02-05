# frozen_string_literal: true

module Mercury
  module Resources
    class Questions < API
      desc 'List all questions belonging to a User',
           is_array: true,
           success: { code: 200, model: Mercury::Entities::Question },
           failure: [
             { code: 401, model: Mercury::Entities::ErrorResponse }
           ]
      get '/questions' do
        authorize(::Question, :index?)
        @questions = current_user.questions.includes([:learnable_resource]).all
        present(@questions, with: Mercury::Entities::Question)
      end

      params do
        requires :quiz_id, type: Integer, documentation: {
          type: 'Integer',
          desc: 'Quiz ID',
          param_type: 'query',
          required: true
        }
      end
      namespace :questions do
        before { authenticate! }
        after { verify_authorized }
        before do
          @quiz = current_user.quizzes.find(params[:quiz_id])
          authorize(@quiz, :update?)
        end

        desc 'List all questions belonging to a Quiz',
             is_array: true,
             success: { code: 200, model: Mercury::Entities::Question },
             failure: [
               { code: 401, model: Mercury::Entities::ErrorResponse }
             ]
        get do
          authorize(::Question, :index?)
          @questions = @quiz.questions.includes(learnable_resource: [:learnable]).all
          present(@questions, with: Mercury::Entities::Question)
        end

        desc 'Create a new question',
             success: { code: 201, model: Mercury::Entities::Question },
             failure: [
               { code: 401, model: Mercury::Entities::ErrorResponse },
               { code: 422, model: Mercury::Entities::ErrorResponse }
             ]
        params do
          optional :name, type: String
          optional :item_order_position, type: Integer, documentation: { param_type: 'body' }
          requires :data, type: JSON, documentation: { type: 'object' }
          requires :question_type, type: String, values: ['flash_card']
        end
        post do
          authorize(::Question, :create?)
          @question = @quiz.questions.new({
                                            user: current_user,
                                            name: params[:name],
                                            data: params[:data],
                                            question_type: params[:question_type],
                                            learnable_resource: @quiz.learnable_resource,
                                            item_order_position: params[:item_order_position]
                                          })

          if @question.save
            present(@question, with: Mercury::Entities::Question, status: 201)
          else
            error!({ errors: @question.errors.messages }, 422)
          end
        end

        desc 'Show a Question',
             success: { code: 200, model: Mercury::Entities::Question },
             failure: [
               { code: 401, model: Mercury::Entities::ErrorResponse },
               { code: 404, model: Mercury::Entities::ErrorResponse }
             ]
        params do
          requires :id, type: Integer, desc: 'The question ID.'
        end
        get ':id' do
          @question = @quiz.questions.find(params[:id])
          authorize(@question, :show?)
          present(@question, with: Mercury::Entities::Question)
        end

        desc 'Update a Question',
             success: { code: 200, model: Mercury::Entities::Question },
             failure: [
               { code: 401, model: Mercury::Entities::ErrorResponse },
               { code: 404, model: Mercury::Entities::ErrorResponse },
               { code: 422, model: Mercury::Entities::ErrorResponse }
             ]
        params do
          requires :id, type: Integer
          optional :name, type: String, allow_blank: false, documentation: { param_type: 'body' }
          optional :item_order_position, type: Integer
          optional :data, type: JSON, allow_blank: false, documentation: { type: 'object' }
          optional :question_type, type: String, values: ['flash_card']
          at_least_one_of :name, :item_order_position, :data, :question_type
        end
        patch ':id' do
          @question = @quiz.questions.find(params[:id])
          authorize(@question, :update?)
          if @question.update(params.except(:id, :quiz_id))
            present(@question, with: Mercury::Entities::Question)
          else
            error!({ errors: @question.errors.full_messages }, 422)
          end
        end

        desc 'Move a Question to a new position within the ordered questions list',
             success: { code: 200, model: Mercury::Entities::MovedQuestion },
             failure: [
               { code: 401, model: Mercury::Entities::ErrorResponse },
               { code: 404, model: Mercury::Entities::ErrorResponse },
               { code: 422, model: Mercury::Entities::ErrorResponse }
             ]
        params do
          requires :id, type: Integer
          requires :item_order_position, type: Integer, documentation: { param_type: 'body' }
        end
        patch ':id/move' do
          @question = @quiz.questions.find(params[:id])
          authorize(@question, :move?)
          if @question.update(item_order_position: params[:item_order_position])
            @other_questions = @quiz.questions.where.not(id: @question.id)
            present({
                      moved_question: @question,
                      other_questions: @other_questions
                    }, with: Mercury::Entities::MovedQuestion)
          else
            error!({ errors: @question.errors.full_messages }, 422)
          end
        end

        desc 'Delete a Question',
             success: { code: 200 },
             failure: [
               { code: 401, model: Mercury::Entities::ErrorResponse },
               { code: 404, model: Mercury::Entities::ErrorResponse }
             ]
        params do
          requires :id, type: Integer
        end
        delete ':id' do
          @question = @quiz.questions.find(params[:id])
          authorize(@question, :destroy?)
          @question.destroy
          body false
        end
      end
    end
  end
end
