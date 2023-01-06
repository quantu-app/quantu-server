# frozen_string_literal: true

module Api
  class QuizzesController < BaseController
    before_action :set_quiz, only: %i[show update destroy]
    def index
      authorize(Quiz)
      @quizzes = current_user.quizzes.all
    end

    def show
      authorize(@quiz)
    end

    def create
      authorize(Quiz)

      @quiz = current_user.quizzes.new(quiz_params)

      if @quiz.save
        @quiz
      else
        render json: {errors: @quiz.errors.full_messages}, status: :unprocessable_entity
      end
    end

    def update
      authorize(@quiz)
      if @quiz.update(quiz_params)
        @quiz
      else
        render json: {errors: @quiz.errors.full_messages }, status: :unprocessable_entity
      end
    end

    def destroy
      authorize(@quiz)
      @quiz.destroy
    end

    private

    def quiz_params
      update_params = params.require(:quiz).permit(:name)
    end

    def set_quiz
      @quiz = current_user.quizzes.find(params[:id])
    end
  end
end
