Rails.application.config.to_prepare do
  Rails.application.configure do
    config.good_job = Rails.application.config_for(:good_job).merge(
      on_thread_error: ->(exception) { Rails.error.report(exception) }
    )
  end
end
