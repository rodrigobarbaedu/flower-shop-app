from .entities.transaction_log import TransactionLog

class ModelTransactionLog():

    @classmethod
    def add_transaction_log(self, db, protocol, web_service, operation, section, user_id, ip):
        try:
            cursor = db.connection.cursor()
            cursor.execute("USE {}".format("flower_shop_transaction_log"))
            cursor.execute("CALL add_transaction_log(%s, %s, %s, %s, %s, %s)", (protocol, web_service, operation, section, user_id, ip))
            db.connection.commit()
            cursor.close()
        except Exception as ex:
            raise Exception(ex)
        
    @classmethod
    def get_transaction_logs(self, db):
        try:
            cursor = db.connection.cursor()
            cursor.execute("USE {}".format("flower_shop_transaction_log"))
            cursor.execute("CALL get_transaction_log()")
            transaction_logs = cursor.fetchall()
            cursor.close()
            return transaction_logs
        except Exception as ex:
            raise Exception(ex)
        