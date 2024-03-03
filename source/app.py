# ----- Imports -----

# Flask Imports
from flask_mysqldb import MySQL
from flask_login import *
from flask import *
# Flask Imports

# Python Imports
from functools import wraps
from config import config
# Python Imports

# Models Imports
from models.model_users import ModelUsers
# Models Imports

# Entities Imports
from models.entities.users import Users
# Entities Imports

# ----- Imports -----

# ----- App Configuration -----

# Flask Configuration
app = Flask(__name__)
db = MySQL(app)
# Flask Configuration

# Login Configuration
login_manager_app = LoginManager(app)
# Login Configuration

# ----- App Configuration -----


# ----- Authentication -----

# Root Route
@app.route("/")

def index():

    return redirect("login")
# Root Route

# Login Route
@app.route("/login", methods=["GET", "POST"])

def login():
    if current_user.is_authenticated == False:
        if request.method == "POST":
            user = Users (
                0,
                request.form["usernameInput"],
                request.form["passwordInput"],
                "",
                "",
                "",
                "",
                "",
                ""
            )
            
            logged_user = ModelUsers.login(db, user)

            if logged_user is not None:
                if logged_user.user_type == 1 or logged_user.user_type == 0:  
                    login_user(logged_user)
                    return redirect(url_for("dashboard"))
            else:
                flash("Usuario o contraseña incorrectos.")
                return render_template("auth/login.html")
        else:
            return render_template("auth/login.html")
    else:
        return redirect(url_for("dashboard"))
# Login Route

# Error 401 Route
@app.route("/error-401")

def error_401():
    
    return render_template("auth/error-401.html")
# Error 401 Route

# Error 403 Route
@app.route("/error-403")

def error_403():
    
    return render_template("auth/error-403.html")
# Error 403 Route

# Login Required Decorator
def login_required(func):
    
    @wraps(func)
    
    def decorated_view(*args, **kwargs):
        if not current_user.is_authenticated:
            return redirect(url_for("error_401"))
        else:
            return func(*args, **kwargs)
    
    return decorated_view
# Login Required Decorator

# Admin Required Decorator
def admin_required(func):

    @wraps(func)
    
    def decorated_view(*args, **kwargs):
        if not current_user.is_authenticated or current_user.user_type != 1:
            return redirect(url_for("error_403"))
        else:
            return func(*args, **kwargs)
    
    return decorated_view
# Admin Required Decorator

# Logout Route
@app.route("/logout")
@login_required

def logout():

    logout_user()
    return redirect(url_for("login"))
# Logout Route

# User Loader
@login_manager_app.user_loader

def load_user(id):

    return ModelUsers.get_users_by_id(db, id)
# User Loader

# ----- Authentication -----


# ----- Dashboard -----

# Dashboard Route
@app.route("/dashboard")
@login_required

def dashboard():
    
    return render_template (
        "public/dashboard.html"
    )
# Dashboard Route

# ----- Dashboard -----


# ----- Users -----

# Users Route
@app.route("/users")
@login_required
@admin_required

def users():
    
    try:
        users = ModelUsers.get_users(db)

        return render_template (
            "public/users-add.html",
            users=users
        )
    except Exception as e:
        raise Exception(e)
# Users Route

# Add User Route
@app.route("/users/add", methods=["GET", "POST"])
@login_required
@admin_required

def add_user():

    if request.method == "POST":
        user = Users (
            0,
            request.form["usernameInput"],
            request.form["passwordInput"],
            request.form["firstnameInput"],
            request.form["lastnameInput"],
            request.form["emailInput"],
            request.form["addressInput"],
            request.form["phoneInput"],
            0 if request.form["userTypeInput"] == "Cliente" else 1
        )

        try:
            ModelUsers.add_user(db, user)

            flash("Usuario agregado correctamente.")
            return redirect(url_for("users"))
        except Exception as e:
            flash("Error al agregar usuario. %s" % e)
    else:
        return render_template (
            "public/users-add.html",
            get_count_shopping_cart=get_count_shopping_cart(current_user.id)
        )
# Add User Route

# Edit User Route
@app.route("/users/edit/<int:id>", methods=["GET", "POST"])
@login_required
@admin_required

def edit_user(id):
    
    if request.method == "POST":
        user = Users (
            id,
            request.form["usernameInput"],
            request.form["passwordInput"],
            request.form["firstnameInput"],
            request.form["lastnameInput"],
            request.form["emailInput"],
            request.form["addressInput"],
            request.form["phoneInput"],
            0 if request.form["userTypeInput"] == "Cliente" else 1
        )

        try:
            ModelUsers.edit_user(db, user)

            flash("Usuario actualizado correctamente.")
            return redirect(url_for("users"))
        except Exception as e:
            flash("Error al actualizar usuario. %s" % e)
    else:
        return render_template (
            "public/users-edit.html",
            user=ModelUsers.get_users_by_id(db, id),
            id=id
        )
# Edit User Route

# Delete User Route
@app.route("/users/delete/<int:id>", methods=["GET", "POST"])
@login_required
@admin_required

def delete_user(id):

    if request.method == "POST":
        ModelUsers.delete_user(db, id)

        flash("Usuario eliminado correctamente.")
        return redirect(url_for("users"))
    else:
        return render_template (
            "public/users-delete.html",
            id=id
        )
# Delete User Route

# ----- Users -----
    

# ----- Main -----

if __name__ == '__main__':
    app.config.from_object(config['development'])
    app.run()

# ----- Main -----