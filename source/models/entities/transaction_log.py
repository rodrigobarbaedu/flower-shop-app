class TransactionLog:
    
    def __init__(self, id, protocol, web_service, operation, section, date_time, user_id, ip) -> None:
        self.id = id
        self.protocol = protocol
        self.web_service = web_service
        self.operation = operation
        self.section = section
        self.date_time = date_time
        self.user_id = user_id
        self.ip = ip