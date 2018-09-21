module Administration
  class NotesController < BaseController
    before_action :set_parent
    before_action :set_note, only: [:show, :edit, :update, :destroy]

    def index
      @notes = @parent.notes
    end

    def new
    end

    def create
      @note = @parent.notes.new(note_params)

      if @note.save
        redirect_to params[:redirect_path], notice: "Basarili!"
      else
        render :new
      end
    end

    def show
    end

    def edit
    end

    def update
      if @note.update(note_params)
        redirect_to [:administration, @note.noteable], notice: "Basarili!"
      else
        render :edit
      end
    end

    def destroy
      @note.destroy

      redirect_to [:administration, @note.noteable], notice: "Basarili!"
    end

    private

    def set_note
      @note = Note.find params[:id]
    end

    def set_parent
      @parent = params.each do |name, value|
        if name =~ /(.+)_id$/
          break $1.classify.constantize.find(value)
        end
      end
    end

    def note_params
      params.require(:note).permit(:body)
    end
  end
end