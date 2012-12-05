class LessonMaterialsController < ApplicationController
  def download_file
    id = params[:id]

    if id.blank?
      redirect_to :root
      return
    end

    lesson_material = LessonMaterial.where(id: id, deleted: false).first

    if lesson_material.blank?
      redirect_to :root
      return
    end

    bucket = AWS::S3.new.buckets[VideoProps::S3_BUCKET_NAME]
    redirect_to  bucket.objects[lesson_material.file_name].url_for(:read, :expires => VideoProps::S3_EXPIRES).to_s
  end
end
