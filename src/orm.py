from peewee import *

# Password should be environment variable not plain text
db = PostgresqlDatabase(
    'shop', 
    user='postgres', 
    password='change.8', 
    host='localhost', 
    port=5432)

class Games(Model):
    id = PrimaryKeyField()
    name = CharField()
    release_year = IntegerField()
    category = CharField()
    mechanic = CharField()
    players_min = IntegerField()
    players_max = IntegerField()
    playtime_min = IntegerField()
    playtime_max = IntegerField()
    min_age = IntegerField()
    is_expansion = BooleanField()

    class Meta:
        database = db
        table_name = 'games'

class GamesToRent(Model):
    id = PrimaryKeyField()
    game_id = ForeignKeyField(Games)
    price = FloatField()
    discount = FloatField()
    date = DateTimeField()
    date_of_delete = DateTimeField()
    comments = CharField()
    rented = BooleanField()

    class Meta:
        database = db
        table_name = 'games_to_rent'

class GamesToSell(Model):
    id = PrimaryKeyField()
    game_id = ForeignKeyField(Games)
    price = FloatField()
    amount = IntegerField()

    class Meta:
        database = db
        table_name = 'games_to_sell'

class AdditionalPayment(Model):
    id = PrimaryKeyField()
    days_paid_time_min = IntegerField()
    days_paid_time_max = IntegerField()
    payment_percent = FloatField()

    class Meta:
        database = db
        table_name = 'additional_payment'

class Competitions(Model):
    id = PrimaryKeyField()
    name = CharField()
    entry_fee = FloatField()
    number_of_participants = IntegerField()
    date = DateTimeField()
    description = CharField()
    game_id = ForeignKeyField(Games)

    class Meta:
        database = db
        table_name = 'competitions'

class Customers(Model):
    id = PrimaryKeyField()
    first_name = CharField()
    last_name = CharField()
    email = CharField()
    phone = CharField()
    discount = FloatField()
    date_of_registration = DateTimeField()

    class Meta:
        database = db
        table_name = 'customers'

class Employees(Model):
    id = PrimaryKeyField()
    first_name = CharField()
    last_name = CharField()
    email = CharField()
    phone = CharField()
    hired_date = DateField()
    position = CharField()
    date_end_of_work = DateField()
    salary = FloatField()

    class Meta:
        database = db
        table_name = 'employees'

class Registration(Model):
    id = PrimaryKeyField()
    first_name = CharField()
    last_name = CharField()
    email = CharField()
    phone = CharField()

    class Meta:
        database = db
        table_name = 'registration'

class Prizes(Model):
    id = PrimaryKeyField()
    amount = IntegerField()
    given = BooleanField()
    kind = CharField()

    class Meta:
        database = db
        table_name = 'prizes'

class Participants(Model):
    id = PrimaryKeyField()
    competition_id = ForeignKeyField(Competitions)
    prize_id = ForeignKeyField(Prizes)
    registration_id = ForeignKeyField(Registration)
    score = IntegerField()
    ranking = IntegerField()
    present = BooleanField()

    class Meta:
        database = db
        table_name = 'participants'

class Rental(Model):
    id = PrimaryKeyField()
    additional_payment_id = ForeignKeyField(AdditionalPayment)
    return_date = DateTimeField(null=True, default=None)
    rental_date = DateTimeField()
    game_id = ForeignKeyField(GamesToRent)
    customer_id = ForeignKeyField(Customers)
    employee_id = ForeignKeyField(Employees)
    return_employee_id = ForeignKeyField(Employees, null=True, default=None)

    class Meta:
        database = db
        table_name = 'rental'

class Sales(Model):
    id = PrimaryKeyField()
    game_id = ForeignKeyField(GamesToSell)
    employee_id = ForeignKeyField(Employees)
    date = DateTimeField()

    class Meta:
        database = db
        table_name = 'sales'

class Meetings(Model):
    id = PrimaryKeyField()
    date = DateTimeField()
    name = CharField()
    fee = FloatField()
    online = BooleanField()

    class Meta:
        database = db
        table_name = 'meetings'