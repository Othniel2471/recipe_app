class ChangeDataTypesForPreparationAndCookingTime < ActiveRecord::Migration[7.0]
  def change
    change_column :recipes, :preparation_time, 'integer USING CAST(preparation_time AS integer)'
    change_column :recipes, :cooking_time, 'integer USING CAST(cooking_time AS integer)'
  end
end
