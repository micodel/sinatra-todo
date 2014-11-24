
helpers do
  def toggle_complete(target_task)
    target_task["is_complete"] = target_task["is_complete"] == true ? false : true
  end
end