# frozen_string_literal: true

class ChangeReportsTitleAndDescriptionNotNull < ActiveRecord::Migration[6.0]
  def change
    change_column_null :reports, :title, false
    change_column_null :reports, :description, false
  end
end
