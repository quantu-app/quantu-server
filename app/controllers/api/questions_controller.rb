# frozen_string_literal: true

module Api
  class QuestionsController < BaseController
    before_action :set_quiz
    before_action :set_question, only: %i[show update destroy]

    def index
      authorize(Question)
      @questions = @quiz.questions.all
    end

    def show
      authorize(@question)
    end

    def create
      authorize(Question)

      @question = @quiz.questions.new(question_params.merge(user: current_user))

      if @question.save
        @question
      else
        render json: {errors: @question.errors.messages}, status: :unprocessable_entity
      end
    end

    def update
      authorize(@question)
      if @question.update(question_params)
        @question
      else
        render json: {errors: @question.errors.full_messages }, status: :unprocessable_entity
      end
    end

    def destroy
      authorize(@question)
      @question.destroy
      head :no_content
    end

    private

    def question_params
      update_params = params.require(:question).permit(:name, :position, data: {})
    end

    def set_quiz
      @quiz = current_user.quizzes.find(params[:quiz_id])
    end

    def set_question
      @question = @quiz.questions.find(params[:id])
    end
  end
end
