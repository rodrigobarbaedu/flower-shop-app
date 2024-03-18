from .entities.shopping_cart import ShoppingCart

class ModelShoppingCart():
    
    @classmethod
    def add_shopping_cart(cls, db, shopping_cart):
        try:
            cursor = db.connection.cursor()
            cursor.execute("CALL sp_add_to_shopping_cart(%s, %s, %s)", (shopping_cart.user_id, shopping_cart.product_id, shopping_cart.quantity))
            db.connection.commit()
        except Exception as ex:
            raise Exception(ex)
        
    @classmethod
    def remove_from_shopping_cart(cls, db, user_id, product_id):
        try:
            cursor = db.connection.cursor()
            cursor.execute("CALL sp_remove_from_shopping_cart(%s, %s)", (user_id, product_id))
            db.connection.commit()
        except Exception as ex:
            raise Exception(ex)
        
    @classmethod
    def clear_shopping_cart(cls, db, user_id):
        try:
            cursor = db.connection.cursor()
            cursor.execute("CALL sp_clear_shopping_cart(%s)", (user_id,))
            db.connection.commit()
        except Exception as ex:
            raise Exception(ex)
    
    @classmethod
    def get_shopping_cart(cls, db, user_id):
        try:
            cursor = db.connection.cursor()
            cursor.execute("CALL sp_get_shopping_cart(%s)", (user_id,))
            shopping_cart = cursor.fetchall()
            return shopping_cart
        except Exception as ex:
            raise Exception(ex)

    @classmethod
    def get_essential_data(cls, db, user_id):
        try:
            cursor = db.connection.cursor()
            cursor.execute("CALL sp_get_essential_data(%s)", (user_id,))
            essential_data = cursor.fetchall()
            return essential_data
        except Exception as ex:
            raise Exception(ex)
        
    @classmethod
    def get_total_price(cls, db, user_id):
        try:
            cursor = db.connection.cursor()
            cursor.execute("CALL sp_get_total_price(%s)", (user_id,))
            total_price = cursor.fetchone()
            return total_price[0]
        except Exception as ex:
            raise Exception(ex)
        
    @classmethod
    def get_count_shopping_cart(cls, db, user_id):
        try:
            cursor = db.connection.cursor()
            cursor.execute("CALL sp_get_count_shopping_cart(%s)", (user_id,))
            count = cursor.fetchone()
            return count[0]
        except Exception as ex:
            raise Exception(ex)