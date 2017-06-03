class AnswersController < ApplicationController
  def create
    @question = Question.find(params[:question_id])
    @answer = @question.answers.create(params[:answer].permit(:body))
    @answer.user_id = current_user.id
    @answer.save
    
    if @answer.save
      flash[:notice] = "Your answer was successfully submitted..."
      redirect_to question_path(@question)
    else
      flash[:notice] = "Answer was not saved!!!"
      redirect_to question_path(@question)
    end
  end

  def destroy
    @question = Question.find(params[:question_id])
    @answer = @question.answers.find(params[:id])
    @answer.destroy
    redirect_to question_path(@question)
  end
  
end
