# Controller for the sections.
class SectionsController < ApplicationController
  before_action :set_section, only: %i[ show edit update destroy ]
  before_action :is_admin, only: %i[ new edit create destroy ]

  # GET /sections or /sections.json
  def index
    @q = Section.ransack(params[:q])
    @sections = @q.result
    @pagy, @sections = pagy(Section.ransack(params[:q]).result(distinct: true))
  end

  # GET /sections/1 or /sections/1.json
  def show
  end

  # GET /sections/new
  def new
    @section = Section.new
  end

  # GET /sections/1/edit
  def edit
  end

  # POST /sections or /sections.json
  def create
    @section = Section.new(section_params)
    @section.id = generate_section_id if @section.section_id.nil?

    respond_to do |format|
      if @section.save
        format.html { redirect_to section_url(@section), notice: 'Section has been created successfully' }
        format.json { render :show, status: :created, location: @section }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @section.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /sections/1 or /sections/1.json
  def update
    respond_to do |format|
      if @section.update(section_params)
        format.html { redirect_to section_url(@section), notice: 'Section was successfully updated.' }
        format.json { render :show, status: :ok, location: @section }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @section.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sections/1 or /sections/1.json
  def destroy
    @section.destroy

    respond_to do |format|
      format.html { redirect_to sections_url, notice: 'Section was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_section
    @section = Section.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def section_params
    params.require(:section).permit(:section_id, :section_number, :course_id, :catalog_number, :term_id, :campus, :days_of_week, :time_start, :time_end, :location, :instructor_name, :instructor_email, :current_num_required_graders, :num_required_graders)
  end

  # Assign section id for new sections. Always assign 1000 to the current maximum +1.
  def generate_section_id
    max_section_id = Section.maximum(:Section_id)
    return max_section_id.nil? ? 1000 : max_section_id + 1
  end
end
