create table if not exists phone_table (
device_id integer,
device_type_id INTEGER,
phone_id INTEGER primary key autoincrement,
brand_id integer,
name TEXT,
color text,
price_cdn real,
network text,
screen_size_inch real,
ppi integer,
resolution text,
ram_mb integer,
capacity integer,
device_size_mm text,
camera_mp real,
plateform text,
gps boolean,
bluetooth boolean,
nfc boolean,
memory_card boolean,
fingerprint boolean,
warranty_m integer,
processor text,
standby_h integer,
talktime_h integer,
weight_g integer
);

create table if not exists brand_table (
brand_name text,
brand_id integer primary key autoincrement
);

create table if not exists device_type_table (
device_type_id integer primary key autoincrement,
device_type_name text

);

create table if not exists device_table (
device_id integer primary key autoincrement,
device_type_id integer
);
