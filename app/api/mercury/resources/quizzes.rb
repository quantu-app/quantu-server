module Mercury
  module Resources
    class Quizzes < API
      namespace :quizzes do
        before { authenticate! }
        after { verify_authorized }

        desc 'List all quizzes'
        get do
          authorize(::Quiz, :index?)
          @quizzes = current_user.quizzes.all
          present(@quizzes, with: Mercury::Entities::Quiz)
        end

        desc 'Create a new quiz'
        params do
          requires :name, type: String, desc: 'Name', allow_blank: false
        end
        post do
          authorize(::Quiz, :create?)
          @quiz = current_user.quizzes.new(name: params[:name])

          if @quiz.save
            present(@quiz, with: Mercury::Entities::Quiz)
          else
            error!({errors: @quiz.errors.full_messages}, 422)
          end
        end

        desc 'show a quiz'
        params do
          requires :id, type: Integer
        end
        get ':id' do
          @quiz = Quiz.find(params[:id])
          authorize(@quiz, :show?)
          present(@quiz, with: Mercury::Entities::Quiz)
        end

        desc 'update a quiz'
        params do
          requires :id, type: Integer
          optional :name, type: String, desc: 'Name', allow_blank: false
        end
        patch ':id' do
          @quiz = Quiz.find(params[:id])
          authorize(@quiz, :update?)
          if @quiz.update(params.except(:id))
            present(@quiz, with: Mercury::Entities::Quiz)
          else
            error!({errors: @quiz.errors.full_messages }, 422)
          end
        end

        desc 'delete a quiz'
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