# -*- encoding : utf-8 -*-
module Company
  class ProductsController < BaseController
    before_action :set_product, only: [:show, :edit, :update, :destroy]
    #before_action :set_product_drawing, only: [:show, :edit, :update, :destroy]

    # GET /company/products
    def index
      @q = Product.where(upid:0).search(params[:q])
      @products = @q.result.paginate(:page => params[:page], :per_page => 100)

    end

    # GET /company/products/1
    def show
    end

    # GET /company/products/new
    def new
      @product = Product.new
    end

    # GET /company/products/1/edit
    def edit
    end

    # POST /company/products
    def create
      @product = Product.new(product_params)

      if @product.save
        product_drawing_params(@product.id)
        redirect_to action: 'index', success: '商品创建成功！'
      else
        flash.now[:danger] = '发生错误！'
        render action: 'new'
      end
    end

    # PATCH/PUT /company/products/1
    def update
      if @product.update(product_params)
        product_drawing_params

        redirect_to @product, success: '商品更新成功！'
      else
        flash.now[:danger] = '发生错误！'
        render action: 'edit'
      end
    end

    # DELETE /company/products/1
    def destroy
      @product.destroy

    end

    private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.find(params[:id])
      end
    def set_product_drawing
      @product_drawings = ProductDrawing.where(product_id:params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def product_params
      params.require(:product).permit(:title, :user_id, :status, :barcode,:orders_count,
                                      :comments_count,:synopsis )
      end
    def product_drawing_params(product_id=nil)
      1.upto(5) do |i|
        product_drawing = params["product_drawing#{i}".to_sym][:product_drawing]
        if product_drawing.present?
          id = params["product_drawing#{i}".to_sym][:id]
          if id.present?
            product_picture = ProductDrawing.find(id)
            product_picture.update_attributes(product_drawing: product_drawing)
          else
            ProductDrawing.create(product_id: product_id, product_drawing: product_drawing, sort: i)
          end
        end
      end

    end
  end
end
