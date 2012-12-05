class CommentsController < ApplicationController
  def create
    if @login_user.blank?
      render :text => "", :status => StatusCodes::BAD_REQUEST
      return
    end

    @comment = Comment.new
    @comment.lesson_id = params[:comment][:lesson_id]
    @comment.user_id = @login_user.id
    @comment.content = params[:comment][:content]
    @comment.is_parent = true

    if @comment.save
      @comment = Comment.new
      @comment.lesson_id = params[:comment][:lesson_id]
      @comments = Comment.where(lesson_id: @comment.lesson_id, is_parent: true, deleted: false).order("id DESC")
                    .paginate(page: params[:comment_page], per_page: Paginate::PER_PAGE_COMMENTS)
      @comment_child = Comment.new
      @comment_child.lesson_id = params[:comment][:lesson_id]
      @lesson = Lesson.where(id: params[:comment][:lesson_id], deleted: false).first
      render :partial => "/comments/comments_top"
    else
      render :partial => "/comments/register_comment", :status => StatusCodes::INVALID_PARAMETERS
    end
  end

  def register_comment_child
    if @login_user.blank?
      render :text => "", :status => StatusCodes::BAD_REQUEST
      return
    end

    @comment_child = Comment.new
    @comment_child.lesson_id = params[:comment][:lesson_id]
    @comment_child.user_id = @login_user.id
    @comment_child.content = params[:comment][:content]
    @comment_child.is_parent = false
    @comment_child.parent_comment_id = params[:comment][:parent_comment_id]

    if @comment_child.save
      @comment_child = Comment.new
      @comment_child.lesson_id = params[:comment][:lesson_id]
      comment = Comment.where(id: params[:comment][:parent_comment_id], deleted: false).first
      render :partial => "/comments/comment", :locals => {comment: comment}
    else
      comment = Comment.where(id: params[:comment][:parent_comment_id], deleted: false).first
      render :partial => "comments/register_comment_child", :status => StatusCodes::INVALID_PARAMETERS, :locals => {comment: comment}
    end
  end

  def delete_comment
    id = params[:id]

    if id.blank?
      render :text => "", :status => StatusCodes::BAD_REQUEST
      return
    end

    @comment = Comment.where(id: id, deleted: false).first

    if @comment.blank?
      render :text => "", :status => StatusCodes::BAD_REQUEST
      return
    end

    @comment.deleted = true

    if @comment.save
      @comments = Comment.where(lesson_id: @comment.lesson_id, is_parent: true, deleted: false).order("id DESC")
                    .paginate(page: params[:comment_page], per_page: Paginate::PER_PAGE_COMMENTS)
      @comment_child = Comment.new
      @comment_child.lesson_id = @comment.lesson_id
      @lesson = Lesson.where(id: @comment.lesson_id, deleted: false).first
      render :partial => "/comments/comments"
    else
      render :text => "", :status => StatusCodes::BAD_REQUEST
      return
    end
  end

  def delete_comment_child
    id = params[:id]

    if id.blank?
      render :text => "", :status => StatusCodes::BAD_REQUEST
      return
    end

    @comment = Comment.where(id: id, deleted: false).first

    if @comment.blank?
      render :text => "", :status => StatusCodes::BAD_REQUEST
      return
    end

    @comment.deleted = true

    if @comment.save
      @comment_child = Comment.new
      @comment_child.lesson_id = @comment.lesson_id
      comment = Comment.where(id: @comment.parent_comment_id, deleted: false).first
      render :partial => "/comments/comment", :locals => {comment: comment}
    else
      render :text => "", :status => StatusCodes::BAD_REQUEST
      return
    end
  end

  def get_comment_list
    id = params[:id]

    if id.blank?
      render :text => "", :status => StatusCodes::BAD_REQUEST
      return
    end

    @comments = Comment.where(lesson_id: id, is_parent: true, deleted: false).order("id DESC")
                    .paginate(page: params[:comment_page], per_page: Paginate::PER_PAGE_COMMENTS)
    @comment_child = Comment.new
    @comment_child.lesson_id = id
    @lesson = Lesson.where(id: id, deleted: false).first
    render :partial => "/comments/comments"
  end
end
