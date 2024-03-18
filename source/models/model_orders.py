from .entities.orders import Orders

class ModelOrders():
    
    @classmethod
    def add_order(cls, db, order):
        try:
            cursor = db.connection.cursor()
            cursor.execute("CALL sp_add_order(%s, %s, %s, %s)", (order.id, order.user_id, order.product_id, order.quantity))
            db.connection.commit()
        except Exception as ex:
            raise Exception(ex)
        
    @classmethod
    def get_last_order_id(cls, db):
        try:
            cursor = db.connection.cursor()
            cursor.execute("CALL sp_get_last_order_id()")
            last_order_id = cursor.fetchone()
            return last_order_id[0]
        except Exception as ex:
            raise Exception(ex)
        
    @classmethod
    def get_count_orders_by_user(cls, db, user_id):
        try:
            cursor = db.connection.cursor()
            cursor.execute("CALL sp_get_count_orders_by_user(%s)", (user_id,))
            count_orders = cursor.fetchone()
            return count_orders[0]
        except Exception as ex:
            raise Exception(ex)
        
    @classmethod
    def get_orders_by_id(cls, db, id):
        try:
            cursor = db.connection.cursor()
            cursor.execute("CALL sp_get_orders_by_id(%s)", (id,))
            orders = cursor.fetchone()
            return orders
        except Exception as ex:
            raise Exception(ex)

    @classmethod
    def get_orders_by_user(cls, db,  user_id):
        try:
            cursor = db.connection.cursor()
            cursor.execute("CALL sp_get_orders_by_user(%s)", (user_id,))
            orders = cursor.fetchall()
            return orders
        except Exception as ex:
            raise Exception(ex)
    
    @classmethod
    def get_orders(cls, db):
        try:
            cursor = db.connection.cursor()
            cursor.execute("CALL sp_get_orders()")
            orders = cursor.fetchall()
            return orders
        except Exception as ex:
            raise Exception(ex)