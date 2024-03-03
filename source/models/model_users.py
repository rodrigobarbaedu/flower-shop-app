from .entities.users import Users

class ModelUsers():
    
    @classmethod
    def login(self, db, user):
        try:
            cursor = db.connection.cursor()
            cursor.execute("CALL sp_verify_identity(%s, %s)", (user.username, user.password))
            row = cursor.fetchone()
            if row[0] != None:
                return Users(row[0], row[1], row[2], row[3], row[4], row[5], row[6], row[7], row[8])
            else:
                return None
        except Exception as ex:
            raise Exception(ex)
    
    @classmethod
    def get_users_by_id(self, db, id):
        try:
            cursor = db.connection.cursor()
            cursor.execute("CALL sp_get_users_by_id(%s)", (id,))
            row = cursor.fetchone()
            if row:
                return Users(row[0], row[1], row[2], row[3], row[4], row[5], row[6], row[7], row[8])
            else:
                return None
        except Exception as ex:
            raise Exception(ex)
        
    @classmethod
    def get_users(cls, db):
        try:
            cursor = db.connection.cursor()
            cursor.execute("CALL sp_get_users()")
            users = cursor.fetchall()
            return users
        except Exception as ex:
            raise Exception(ex)
        
    @classmethod
    def add_user(self, db, user):
        try:
            cursor = db.connection.cursor()
            cursor.execute("CALL sp_add_user(%s, %s, %s, %s, %s, %s, %s, %s)", (user.username, user.password, user.firstname, user.lastname, user.email, user.physical_address, user.phone, user.user_type))
            db.connection.commit()
        except Exception as ex:
            raise Exception(ex)
        
    @classmethod
    def edit_user(self, db, user):
        try:
            cursor = db.connection.cursor()
            cursor.execute("CALL sp_edit_user(%s, %s, %s, %s, %s, %s, %s, %s, %s)", (user.id, user.username, user.password, user.firstname, user.lastname, user.email, user.physical_address, user.phone, user.user_type))
            db.connection.commit()
        except Exception as ex:
            raise Exception(ex)
        
    @classmethod
    def delete_user(self, db, id):
        try:
            cursor = db.connection.cursor()
            cursor.execute("CALL sp_delete_user(%s)", (id,))
            db.connection.commit()
        except Exception as ex:
            raise Exception(ex)