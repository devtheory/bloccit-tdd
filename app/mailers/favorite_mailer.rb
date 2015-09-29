class FavoriteMailer < ApplicationMailer

  def new_comment(user, post, comment)
    headers["Message-ID"] = "<comments/#{comment.id}@devtheory-bloccit-tdd.herokuapp.com>"
    headers["In-Reply-To"] = "<post/#{post.id}@devtheory-bloccit-tdd.herokuapp.com>"
    headers["References"] = "<post/#{post.id}@devtheory-bloccit-tdd.herokuapp.com>"

    @user, @post, @comment = user, post, comment

    mail(to: user.email, subject: "New comment on #{post.title}")
  end
end
