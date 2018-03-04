class PictureMailer < ApplicationMailer
  def picture_mail(picture)
   @picture = picture
   @picture_email = @picture.user.email

   mail to: @picture_email , subject: "投稿が完了したと言ったな、、、あれは嘘だ！！( ͡° ͜ʖ ͡°)"
  end
end
