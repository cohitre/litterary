class GeneralController < ApplicationController

  def index
  end

  def help

  end


  def management
    @users = User.find(:all)
  end

  def user
    @user = User.find(:first , :conditions => ['login = ?' , params[:id] ] )
    @user_notes = Note.paginate( {
      :page => params[:page] || "1" ,
      :order => 'created_at DESC',
      :conditions => ['user_id = ?' , @user.id] ,
      :per_page     => 20
    } )
  end

  def notes

    @notes = Note.paginate( :order => 'created_at DESC',
    :page => params[:page] || "1",
    :order => 'created_at DESC' ,
    :conditions => 'shared = 1 AND CHAR_LENGTH( name ) > 0' ,
    :per_page  =>  20 )

  end

  def comments
    @user = User.find( :first , :conditions => ['login = ?' , params[:id] ] )
    @user_comments  = @user.note_comments.paginate(
    :page => params[:page]|| "1",
    :order         => 'note_comments.created_at DESC',
    :per_page     => 20 , :include => 'note'
    )
  end

  def user_comments
    @user = User.find( params[:id] )
    @comment_pages, @user_comments = paginate(:note_comment, :conditions => ['note_comments.user_id = ?' , @user.id],
    :order         => 'note_comments.created_at DESC',
    :per_page     => 20 , :include => 'note')
    render :action => 'comments'
  end

  def add_user_comment

    user = User.find(params[:id])
    unless session['user'].nil?
      author = session['user']
      comm = UserComment.new
      comm.message = params[:comment]
      comm.author = author
      comm.user = user
      comm.time = Time.now
      comm.save
    end
    redirect_to :action => 'talk' , :id => user.login
  end

  def favorites
    @user = User.find( :first , :conditions => ['login = ?' , params[:id] ] )
    @authored = User.find_by_sql( ['SELECT * from users INNER JOIN authors_users ON users.id = authors_users.user_id WHERE (authors_users.author_id = ?)'  , @user.id ] )
  end

  def talk
    @user = User.find( :first , :conditions => ['login = ?' , params[:id] ] )
    @comments = UserComment.find(:all , :conditions => ['user_id = ?',@user.id ] , :order => 'time DESC')
  end

  def show_description
    @user = User.find( params[:id] )
    @can_edit = ( !session['user'].nil? ) && ( session['user'].id  == @user.id )
    render :partial => 'show_description'
  end

  def highlight_text
    @note = Note.find( params[:id] )
  end

  def submit_highlight
    @note = Note.find( params[:id] )
    @kind = Kind.find( params[:kind])
  end

  def toggle_favorite
    @note = Note.find(params[:id])
    if session['user'].favorites.include? @note
      session['user'].favorites.delete( @note )
    else
      session['user'].favorites << @note
    end
    session['user'].save
    render :partial => 'favorite'
  end

  def toggle_author
    @user = User.find(params[:id])
    if session['user'].authors.include? @user
      session['user'].authors.delete( @user )
    else
      session['user'].authors << @user
    end
    session['user'].save
    render :partial => 'author'
  end

  def toggle_sidenotes
    if params[:kind].nil? || params[:kind] == 'all'
      @toggle = 'all'
    end
    render :partial => 'toggle_sidenotes'
  end

  def people
    @users = User.paginate(:page => params[:page]||"1",
    :order         => 'created_at DESC',
    :per_page     => 20)
    #    @users = User.find(:all , :limit => 10 , :order => 'created_at DESC')
  end

  def view_citations
    @note = Note.find(params[:id])
    citation = Citation.find( params[:citation_id] )
    if !citation.nil?
      if session[:citations].include? citation
        session[:citations].delete( citation )
      else
        session[:citations] << citation
      end
    end

    @note_text = @note.mark_citations( session[:citations] )

    render :partial => 'read_area'
  end

end
