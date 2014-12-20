# -*- encoding : utf-8 -*-
module Admin
  class ClassificationsController < BaseController

    before_action :set_admin_classification, only: [:index_pre,:show, :edit, :update, :destroy]

    # GET /admin/classifications
    def index
      #@classifications = Classification.all
      @q = Classification.where(upid:0).search(params[:q])
      @classifications = @q.result.paginate(:page => params[:page], :per_page => 100)

    end

    def index_pre
      @q = Classification.where(upid:params[:id]).search(params[:q])
      @classifications = @q.result.paginate(:page => params[:page], :per_page => 100)
      result = {}

      classification =  Classification.find(params[:id])

          classification.level.downto(0) do
            logger.info "#{classification.name}=="
        result[classification.id] = classification.name
        classification =  classification.upid == 0 ? Classification.find(classification.id) : Classification.find(classification.upid)
      end
      @result = Hash[result.sort]
    end

    # GET /admin/classifications/1
    def show
    end

    def new_pre
      @classification = Classification.new(upid:params[:id],level:Classification.find(params[:id]).level+1)
    end

    # GET /admin/classifications/new
    def new
      @classification = Classification.new
    end

    # GET /admin/classifications/1/edit
    def edit
    end

    # POST /admin/classifications
    def create
      @classification = Classification.new(admin_classification_params)

      if @classification.save

        redirect_to (@classification.upid == 0 ? {action:'index'} : admin_indexs_path(@classification.upid)), success: '分类创建成功！'
      else
        flash.now[:danger] = '发生错误！'
        render action: 'new'
      end
    end

    # PATCH/PUT /admin/classifications/1
    def update
      if @classification.update(admin_classification_params)
        redirect_to admin_classifications_path, success: '分类更新成功！'
      else
        flash.now[:danger] = '发生错误！'
        render action: 'edit'
      end
    end

    # DELETE /admin/classifications/1
    def destroy
      result = [@classification.id]

      loop do
        classification = Classification.where(upid:result)
        if classification.present?
          result = []
          classification.each {|cf| result << cf.id}
          classification.delete_all
        else
          break
        end
      end
      @classification.destroy
      #redirect_to admin_classifications_url, notice: 'Classification was successfully destroyed.'
    end

    private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_classification
      @classification = Classification.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def admin_classification_params
      params.require(:classification).permit(:name, :level, :upid, :state )
    end
  end
end
