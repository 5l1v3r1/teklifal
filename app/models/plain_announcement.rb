# This is a flying model
# No persisting to the database
class PlainAnnouncement
  include ActiveModel::Conversion
  extend ActiveModel::Naming
  attr_accessor :announcement
  delegate :save, :errors, :new_record?, to: :announcement

  def initialize announcement_id: nil
    @announcement = Announcement.find_or_initialize_by id: announcement_id
  end

  def id
    @id ||= -1
  end

  def build_announcement
    announcement
  end

  def assign_attributes content_params
    announcement.assign_attributes content_params[:announcement]
  end

  def update content_params
    announcement.update content_params[:announcement]
  end

  def persisted?
    false
  end

  def self.find id
    new id
  end
end