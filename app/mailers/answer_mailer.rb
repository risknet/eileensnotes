class AnswerMailer < ActionMailer::Base
  default from: "eileensnotes@risknetlee.com"

  # notify the owner of question for a newly posted answer
  def notify_owner(note, url)
    @owner = User.find_by_id(note.user_id)
    @question = note.question
    @url = url
    mail(to: @owner.email, subject: 'Your question just received a new answer')
  end
end
