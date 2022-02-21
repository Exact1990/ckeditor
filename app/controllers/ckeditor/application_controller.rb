class Ckeditor::ApplicationController < Ckeditor.parent_controller.constantize
  layout 'ckeditor/application'

  before_action :find_asset, only: [:destroy]
  before_action :ckeditor_authorize!
  before_action :authorize_resource

  protected

  def respond_with_asset(asset)
    response = Ckeditor::AssetResponse.new(asset, request)
    callback = ckeditor_before_create_asset(asset)

    if callback && asset.save
      render response.success(config.relative_url_root)
    else
      render response.errors
    end
  end
end
