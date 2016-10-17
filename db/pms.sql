create database if not exists patentdb default character set utf8 default collate utf8_general_ci;

use patentdb;

create table if not exists users (
	user_id int auto_increment primary key, 
	username varchar(30) not null unique, 
	name varchar(30),
	password varchar(128) not null,
	email varchar(254), 
	phone varchar(30),
	join_date timestamp,
	enabled boolean not null default true
);

create table if not exists authorities (
	username varchar(50) not null,
	authority varchar(50) not null,
	constraint fk_authorities_users foreign key(username) references users(username)
);
create unique index ix_auth_username on authorities (username,authority);

create table if not exists groups (
	id bigint primary key auto_increment ,
	group_name varchar(50) not null
);

create table if not exists group_authorities (
	group_id bigint not null,
	authority varchar(50) not null,
	constraint fk_group_authorities_group foreign key(group_id) references groups(id)
);

create table if not exists group_members (
	id bigint primary key auto_increment,
	username varchar(50) not null,
	group_id bigint not null,
	constraint fk_group_members_group foreign key(group_id) references groups(id)
);

create table if not exists persistent_logins (
	username varchar(64) not null,
	series varchar(64) primary key,
	token varchar(64) not null,
	last_used timestamp not null
);

CREATE TABLE if not exists acl_sid (
	id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
	principal BOOLEAN NOT NULL,
	sid VARCHAR(100) NOT NULL,
	UNIQUE KEY unique_acl_sid (sid, principal)
);

CREATE TABLE if not exists acl_class (
	id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
	class VARCHAR(100) NOT NULL,
	UNIQUE KEY uk_acl_class (class)
);

CREATE TABLE if not exists acl_object_identity (
	id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
	object_id_class BIGINT UNSIGNED NOT NULL,
	object_id_identity BIGINT NOT NULL,
	parent_object BIGINT UNSIGNED,
	owner_sid BIGINT UNSIGNED,
	entries_inheriting BOOLEAN NOT NULL,
	UNIQUE KEY uk_acl_object_identity (object_id_class, object_id_identity),
	CONSTRAINT fk_acl_object_identity_parent FOREIGN KEY (parent_object) REFERENCES acl_object_identity
	(id),
	CONSTRAINT fk_acl_object_identity_class FOREIGN KEY (object_id_class) REFERENCES acl_class (id),
	CONSTRAINT fk_acl_object_identity_owner FOREIGN KEY (owner_sid) REFERENCES acl_sid (id)
);

CREATE TABLE if not exists acl_entry (
	id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
	acl_object_identity BIGINT UNSIGNED NOT NULL,
	ace_order INTEGER NOT NULL,
	sid BIGINT UNSIGNED NOT NULL,
	mask INTEGER UNSIGNED NOT NULL,
	granting BOOLEAN NOT NULL,
	audit_success BOOLEAN NOT NULL,
	audit_failure BOOLEAN NOT NULL,
	UNIQUE KEY unique_acl_entry (acl_object_identity, ace_order),
	CONSTRAINT fk_acl_entry_object FOREIGN KEY (acl_object_identity) REFERENCES acl_object_identity (id),
	CONSTRAINT fk_acl_entry_acl FOREIGN KEY (sid) REFERENCES acl_sid (id)
);

create table if not exists patent_types (
	patent_type_id int auto_increment primary key,
	patent_type_desc char(12) not null unique
);
	
create table if not exists patent_status (
	patent_status_id int auto_increment primary key,
	patent_status_desc varchar(50) not null unique
);

create table if not exists patents (
	patent_id bigint auto_increment primary key,
	app_no varchar(30) not null , 
	patent_name varchar(200), 
	patent_type int,
	app_date date, 
	app_person varchar(100), 
	invent_person varchar(100),
	patent_status int, 
	internal_code varchar(100), 
	patent_owner int,
	constraint unique_patents_no_owner unique idx_unique_patents_no_owner (patent_owner, app_no),
	constraint fk_patent_owner foreign key idx_fk_patent_owner (patent_owner) references users(user_id) on delete cascade,
	constraint fk_patent_patent_type foreign key idx_fk_patent_patent_type (patent_type) references patent_types(patent_type_id),
	constraint fk_patent_status foreign key idx_fk_patent_status (patent_status) references patent_status(patent_status_id)
);

create table if not exists share_patents (
	patent bigint,
	share_by int,
	share_to int,
	constraint pk_share_patents primary key (patent, share_by, share_to),
	constraint fk_share_patents_patent foreign key idx_fk_share_patents_patent (patent) references patents(patent_id) on delete cascade,
	constraint fk_share_patents_share_by foreign key idx_fk_share_patents_share_by (share_by) references users(user_id) on delete cascade,
	constraint fk_share_patents_share_to foreign key idx_fk_share_patents_share_to (share_to) references users(user_id) on delete cascade
);

create table if not exists user_patents (
	user int,
	patent bigint,
	constraint pk_user_patents primary key (user, patent),
	constraint fk_user_patent_user foreign key idx_fk_user_patent_user (user) references users(user_id) on delete cascade,
	constraint fk_user_patent_patent foreign key idx_fk_user_patent_patent (patent) references patents(patent_id) on delete cascade
);

create table if not exists fee_payment_status (
	fee_payment_status_id int auto_increment primary key,
	fee_payment_status_desc varchar(10) not null unique
);

create table if not exists fee_monitor_status (
	fee_monitor_status_id int auto_increment primary key,
	fee_monitor_status_desc varchar(10) not null unique
);

create table if not exists fees (
	fee_id bigint auto_increment primary key,
	deadline date not null comment '缴费截止日', 
	fee_type varchar(80) not null comment '费用种类',
	amount int not null, 
	fee_payment_status int default 1 comment '缴费状态', 
	patent bigint not null,
	process_user int comment '处理用户', 
	fee_monitor_status int default 1 comment '监控状态', 
	fee_owner int comment '拥有人', 
	invoice_title varchar(200) comment '发票抬头',
	UNIQUE KEY uk_fees_patent_fee (patent, fee_type, deadline, fee_owner),
	constraint fk_fee_owner foreign key idx_fk_fee_owner (fee_owner) references users(user_id) on delete cascade,
	constraint fk_fee_payment_status foreign key idx_fk_fee_payment_status (fee_payment_status) references fee_payment_status(fee_payment_status_id),
	constraint fk_fee_process_user foreign key idx_fk_fee_process_user (process_user) references users(user_id),
	constraint fk_fee_monitor_status foreign key idx_fk_fee_monitor_status (fee_monitor_status) references fee_monitor_status(fee_monitor_status_id),
	constraint fk_fee_patent foreign key idx_fk_fee_patent (patent) references patents(patent_id) on delete cascade
);

create table if not exists friends (
	user int,
	friend int,
	constraint pk_friends primary key (user, friend),
	constraint fk_friends_user foreign key(user) references users(user_id),
	constraint fk_friends_friend foreign key(friend) references users(user_id)
);

create table if not exists friend_request_process_status (
	friend_request_process_status_id int auto_increment primary key,
	friend_request_process_status_desc varchar(12) not null unique
);
	
create table if not exists friend_requests (
	from_user int, 
	to_user int, 
	message varchar(100),
	request_process_status int default 1 not null comment '处理状态',
	constraint pk_friend_requests primary key (from_user, to_user, request_process_status),
	constraint fk_friend_request_from_user foreign key idx_fk_friend_request_from_user (from_user) references users(user_id) on delete cascade,
	constraint fk_friend_request_to_user foreign key idx_fk_friend_request_to_user (to_user) references users(user_id) on delete cascade,
	constraint fk_friend_request_process_status foreign key idx_fk_friend_request_process_status (request_process_status) references friend_request_process_status(friend_request_process_status_id)
);

create table if not exists notice_process_status (
	notice_process_status_id int auto_increment primary key, 
	notice_process_status_desc varchar(10)
);
	
create table if not exists notice_types (
	notice_type_id int auto_increment primary key, 
	notice_type_desc varchar(30)
);

create table if not exists notice_paper_apply_types (
	notice_paper_apply_type_id int auto_increment primary key, 
	notice_paper_apply_type_desc varchar(12)
);

create table if not exists notices (
	notice_id bigint auto_increment primary key, 
	notice_sequence varchar(30), 
	dispatch_sequence varchar(30), 
	time_limit int,
	dispatch_date date, 
	notice_name varchar(100), 
	notice_code varchar(30), 
	zip_bid varchar(30),
	dmh_flag varchar(10), 
	archive_no varchar(30), 
	zipfile_name varchar(100),
	patent bigint not null, 
	process_status int default 1 not null, 
	process_user int,
	notice_type int, 
	paper_apply_type int default 1 not null,
	UNIQUE KEY uk_notices_patent_notice_sequence (patent, notice_sequence),
	constraint fk_notice_patent foreign key idx_fk_notice_patent (patent) references patents(patent_id) on delete cascade,
	constraint fk_notice_process_status foreign key idx_fk_notice_process_status (process_status) references notice_process_status(notice_process_status_id),
	constraint fk_notice_process_user foreign key idx_fk_notice_process_user (process_user) references users(user_id),
	constraint fk_notice_type foreign key idx_fk_notice_type (notice_type) references notice_types(notice_type_id),
	constraint fk_notice_paper_apply_type foreign key idx_fk_notice_paper_apply_type (paper_apply_type) references notice_paper_apply_types(notice_paper_apply_type_id)
);

create table if not exists provinces (
	id int primary key,
	name varchar(30) not null unique
);

create table if not exists cities (
	id bigint primary key,
	name varchar(30) not null,
	province int not null,
	constraint fk_cities_province foreign key(province) references provinces(id)
);

create table if not exists districts (
	id bigint primary key,
	name varchar(30) not null,
	city bigint not null,
	constraint fk_districts_city foreign key(city) references cities(id)
);

create table if not exists streets (
	id bigint primary key,
	name varchar(50) not null,
	district bigint not null,
	constraint fk_streets_district foreign key(district) references districts(id)
);

create table if not exists contact_addresses (
	id int primary key auto_increment,
	receiver varchar(50) not null,
	province int not null,
	city bigint not null,
	district bigint not null,
  	street bigint not null,
  	detail_address varchar(100) not null,
  	phone varchar(20),
  	mobile varchar(20),
 	email varchar(50),
 	user int not null,
 	is_default boolean not null default 0,
	constraint fk_contact_addresses_province foreign key(province) references provinces(id),
	constraint fk_contact_addresses_city foreign key(city) references cities(id),
	constraint fk_contact_addresses_district foreign key(district) references districts(id),
	constraint fk_contact_addresses_street foreign key(street) references streets(id),
	constraint fk_contact_addresses_user foreign key(user) references users(user_id)
);

create table if not exists order_status (
	order_status_id int primary key auto_increment,
	status_description varchar(20) not null unique
);

create table if not exists payment_methods (
	payment_method_id int primary key auto_increment,
	payment_method varchar(30) not null unique
);

create table if not exists orders (
	order_id bigint primary key auto_increment,
	order_status int not null default 1,
	post_address int,
	last_update_time timestamp default current_timestamp on update current_timestamp not null,
	amount int not null,
	user int not null,
	process_user int,
	received boolean default 0,
	express_company varchar(100),
	express_no varchar(100),
	send_time date,
	courier varchar(20),
	courier_phone varchar(30),
	create_time timestamp not null,
	payment_method int,
	constraint fk_orders_order_status foreign key(order_status) references order_status(order_status_id),
	constraint fk_orders_user foreign key(user) references users(user_id),
	constraint fk_orders_process_user foreign key(process_user) references users(user_id),
	constraint fk_orders_payment_method foreign key(payment_method) references payment_methods(payment_method_id)
) auto_increment=123412341234;

alter table orders add column pay_time timestamp;

create table if not exists order_items (
	item_id bigint primary key auto_increment,
	order_id bigint not null,
	fee_id bigint not null,
	UNIQUE KEY uk_order_items_order_fee (order_id, fee_id),
	constraint fk_order_items_order foreign key(order_id) references orders(order_id) on delete cascade,
	constraint fk_order_items_fee foreign key(fee_id) references fees(fee_id)
);

create table fee_types (
	type_id int primary key auto_increment,
	patent_type int not null,
	type_code varchar(30) not null,
	type_text varchar(100) not null,
	constraint fk_fee_type_patent foreign key idx_fk_fee_type_patent (patent_type) references patent_types(patent_type_id) on delete cascade 
);
	
INSERT INTO friend_request_process_status (friend_request_process_status_id, friend_request_process_status_desc)
VALUES
	(1, '未处理'),
	(2, '通过验证'),
	(3, '拒绝请求');

INSERT INTO fee_monitor_status (fee_monitor_status_id, fee_monitor_status_desc)
VALUES
	(1, '未加入'),
	(2, '已加入');

INSERT INTO fee_payment_status (fee_payment_status_id, fee_payment_status_desc)
VALUES
	(1, '应缴费'),
	(2, '已支付'),
	(3, '已交局'),
	(4, '待支付'),
	(5, '缴费成功');
	
INSERT INTO notice_paper_apply_types (notice_paper_apply_type_id, notice_paper_apply_type_desc)
VALUES
	(1, '未申请'),
	(2, '申请纸件'),
	(3, '处理中'),
	(4, '已发送'),
	(5, '无纸件');
	
INSERT INTO notice_process_status (notice_process_status_id, notice_process_status_desc)
VALUES
	(1, '未处理'),
	(2, '已处理'),
	(3, '已放弃'),
	(4, '处理中');

INSERT INTO notice_types (notice_type_id, notice_type_desc)
VALUES
	(1, '新案受理'),
	(2, '缴费通知'),
	(3, '补正审查'),
	(4, '专利授权'),
	(5, '权利丧失'),
	(6, '手续合格'),
	(7, '其他'),
	(8, '驳回决定');

INSERT INTO patent_status (patent_status_id, patent_status_desc)
VALUES
	(1, '等待申请费'),
	(2, '待答复'),
	(3, '等年登印费'),
	(4, '待恢复'),
	(5, '失效'),
	(6, '专利权维持'),
	(7, '其他');

INSERT INTO patent_types (patent_type_id, patent_type_desc)
VALUES
	(1, '发明'),
	(2, '实用新型'),
	(3, '外观设计');	
	

INSERT INTO order_status
VALUES
	(1, '待支付'),
	(2, '已支付'),
	(3, '已取消'),
	(4, '已缴费');
	
INSERT INTO payment_methods
VALUES
	(1, '支付宝'),
	(2, '银联卡');
	
INSERT INTO groups
VALUES
	(1, 'USER'),
	(2, 'ORDER');
	
INSERT INTO group_authorities
VALUES
	(1, 'ROLE_USER'),
	(2, 'ROLE_ORDER');
	
insert into fee_types(patent_type, type_code, type_text) values(1, '40872083405356', '发明专利第17年年费');
insert into fee_types(patent_type, type_code, type_text) values(1, '40872083325332', '权利要求附加费');
insert into fee_types(patent_type, type_code, type_text) values(1, '40872083205320', '发明专利登记印刷费');
insert into fee_types(patent_type, type_code, type_text) values(1, '40872083405358', '发明专利第19年年费');
insert into fee_types(patent_type, type_code, type_text) values(1, '40872083405354', '发明专利第15年年费');
insert into fee_types(patent_type, type_code, type_text) values(1, '40872083405352', '发明专利第13年年费');
insert into fee_types(patent_type, type_code, type_text) values(1, '40872083405341', '发明专利第2年年费');
insert into fee_types(patent_type, type_code, type_text) values(1, '40872083335333', '说明书附加费');
insert into fee_types(patent_type, type_code, type_text) values(1, '40872083405346', '发明专利第7年年费');
insert into fee_types(patent_type, type_code, type_text) values(1, '40872083405348', '发明专利第9年年费');
insert into fee_types(patent_type, type_code, type_text) values(1, '40872082105210', '发明专利申请费');
insert into fee_types(patent_type, type_code, type_text) values(1, '40872083405344', '发明专利第5年年费');
insert into fee_types(patent_type, type_code, type_text) values(1, '40872082405240', '发明专利复审费');
insert into fee_types(patent_type, type_code, type_text) values(1, '40872083405349', '发明专利第10年年费');
insert into fee_types(patent_type, type_code, type_text) values(1, '40872083405342', '发明专利第3年年费');
insert into fee_types(patent_type, type_code, type_text) values(1, '40872082505250', '变更费');
insert into fee_types(patent_type, type_code, type_text) values(1, '40872083405355', '发明专利第16年年费');
insert into fee_types(patent_type, type_code, type_text) values(1, '40872083405357', '发明专利第18年年费');
insert into fee_types(patent_type, type_code, type_text) values(1, '40872082305230', '发明专利申请审查费');
insert into fee_types(patent_type, type_code, type_text) values(1, '40872083405359', '发明专利第20年年费');
insert into fee_types(patent_type, type_code, type_text) values(1, '20761581515151', '印花税');
insert into fee_types(patent_type, type_code, type_text) values(1, '40872083405353', '发明专利第14年年费');
insert into fee_types(patent_type, type_code, type_text) values(1, '40872083405340', '发明专利第1年年费');
insert into fee_types(patent_type, type_code, type_text) values(1, '40872083405351', '发明专利第12年年费');
insert into fee_types(patent_type, type_code, type_text) values(1, '40872083315331', '延长费');
insert into fee_types(patent_type, type_code, type_text) values(1, '40872082115211', '发明专利文印费');
insert into fee_types(patent_type, type_code, type_text) values(1, '40872083400001', '年费费减');
insert into fee_types(patent_type, type_code, type_text) values(1, '40872082705270', '恢复权利请求费');
insert into fee_types(patent_type, type_code, type_text) values(1, '40872083405347', '发明专利第8年年费');
insert into fee_types(patent_type, type_code, type_text) values(1, '40872082605260', '优先权要求费');
insert into fee_types(patent_type, type_code, type_text) values(1, '40872083525381', '发明专利年费滞纳金');
insert into fee_types(patent_type, type_code, type_text) values(1, '40872083405345', '发明专利第6年年费');
insert into fee_types(patent_type, type_code, type_text) values(1, '40872083405343', '发明专利第4年年费');
insert into fee_types(patent_type, type_code, type_text) values(1, '40872083405350', '发明专利第11年年费');
insert into fee_types(patent_type, type_code, type_text) values(1, '40872082905290', '发明专利权无效宣告请求费');
insert into fee_types(patent_type, type_code, type_text) values(2, '40872083415365', '实用新型专利第6年年费');
insert into fee_types(patent_type, type_code, type_text) values(2, '40872083325332', '权利要求附加费');
insert into fee_types(patent_type, type_code, type_text) values(2, '40872083415363', '实用新型专利第4年年费');
insert into fee_types(patent_type, type_code, type_text) values(2, '40872083415367', '实用新型专利第8年年费');
insert into fee_types(patent_type, type_code, type_text) values(2, '40872082325232', '实用新型专利权评价报告请求费');
insert into fee_types(patent_type, type_code, type_text) values(2, '40872082415241', '实用新型专利复审费');
insert into fee_types(patent_type, type_code, type_text) values(2, '40872083415361', '实用新型专利第2年年费');
insert into fee_types(patent_type, type_code, type_text) values(2, '40872083335333', '说明书附加费');
insert into fee_types(patent_type, type_code, type_text) values(2, '40872083415369', '实用新型专利第10年年费');
insert into fee_types(patent_type, type_code, type_text) values(2, '40872082315231', '实用新型检索费');
insert into fee_types(patent_type, type_code, type_text) values(2, '40872082505250', '变更费');
insert into fee_types(patent_type, type_code, type_text) values(2, '40872083535382', '实用新型专利年费滞纳金');
insert into fee_types(patent_type, type_code, type_text) values(2, '40872083415364', '实用新型专利第5年年费');
insert into fee_types(patent_type, type_code, type_text) values(2, '40872083415362', '实用新型专利第3年年费');
insert into fee_types(patent_type, type_code, type_text) values(2, '40872083415368', '实用新型专利第9年年费');
insert into fee_types(patent_type, type_code, type_text) values(2, '20761581515151', '印花税');
insert into fee_types(patent_type, type_code, type_text) values(2, '40872083415366', '实用新型专利第7年年费');
insert into fee_types(patent_type, type_code, type_text) values(2, '40872083315331', '延长费');
insert into fee_types(patent_type, type_code, type_text) values(2, '40872083400001', '年费费减');
insert into fee_types(patent_type, type_code, type_text) values(2, '40872082135213', '实用新型专利申请费');
insert into fee_types(patent_type, type_code, type_text) values(2, '40872083415360', '实用新型专利第1年年费');
insert into fee_types(patent_type, type_code, type_text) values(2, '40872082705270', '恢复权利请求费');
insert into fee_types(patent_type, type_code, type_text) values(2, '40872082605260', '优先权要求费');
insert into fee_types(patent_type, type_code, type_text) values(2, '40872083225322', '实用新型专利登记印刷费');
insert into fee_types(patent_type, type_code, type_text) values(2, '40872082915291', '实用新型专利权无效宣告请求费');
insert into fee_types(patent_type, type_code, type_text) values(3, '40872083325332', '权利要求附加费');
insert into fee_types(patent_type, type_code, type_text) values(3, '40872083425378', '外观设计专利第9年年费');
insert into fee_types(patent_type, type_code, type_text) values(3, '20761581515151', '印花税');
insert into fee_types(patent_type, type_code, type_text) values(3, '40872082925292', '外观设计专利权无效宣告请求费');
insert into fee_types(patent_type, type_code, type_text) values(3, '40872083425379', '外观设计专利第10年年费');
insert into fee_types(patent_type, type_code, type_text) values(3, '40872083315331', '延长费');
insert into fee_types(patent_type, type_code, type_text) values(3, '40872083425374', '外观设计专利第5年年费');
insert into fee_types(patent_type, type_code, type_text) values(3, '40872083400001', '年费费减');
insert into fee_types(patent_type, type_code, type_text) values(3, '40872083425375', '外观设计专利第6年年费');
insert into fee_types(patent_type, type_code, type_text) values(3, '40872083425377', '外观设计专利第8年年费');
insert into fee_types(patent_type, type_code, type_text) values(3, '40872083425371', '外观设计专利第2年年费');
insert into fee_types(patent_type, type_code, type_text) values(3, '40872083425376', '外观设计专利第7年年费');
insert into fee_types(patent_type, type_code, type_text) values(3, '40872083425370', '外观设计专利第1年年费');
insert into fee_types(patent_type, type_code, type_text) values(3, '40872082145214', '外观设计专利申请费');
insert into fee_types(patent_type, type_code, type_text) values(3, '40872083425372', '外观设计专利第3年年费');
insert into fee_types(patent_type, type_code, type_text) values(3, '40872083425373', '外观设计专利第4年年费');
insert into fee_types(patent_type, type_code, type_text) values(3, '40872082425242', '外观设计专利复审费');
insert into fee_types(patent_type, type_code, type_text) values(3, '40872082705270', '恢复权利请求费');
insert into fee_types(patent_type, type_code, type_text) values(3, '40872083335333', '说明书附加费');
insert into fee_types(patent_type, type_code, type_text) values(3, '40872082605260', '优先权要求费');
insert into fee_types(patent_type, type_code, type_text) values(3, '40872082325233', '外观设计专利权评价报告请求费');
insert into fee_types(patent_type, type_code, type_text) values(3, '40872082505250', '变更费');
insert into fee_types(patent_type, type_code, type_text) values(3, '40872083235323', '外观设计专利登记印刷费');
insert into fee_types(patent_type, type_code, type_text) values(3, '40872083545383', '外观设计专利年费滞纳金');
insert into fee_types(patent_type, type_code, type_text) values(3, '40872083545383', '外观设计专利年费滞纳金');

ALTER TABLE orders ADD invoice VARCHAR(100) NULL;
ALTER TABLE orders ADD express_fee INT ;
ALTER TABLE orders ADD service_fee INT ;
ALTER TABLE orders ADD invoice_fee INT;

ALTER TABLE patents ADD COLUMN patent_status_text VARCHAR(150);	
ALTER TABLE orders DROP COLUMN courier;
ALTER TABLE orders DROP COLUMN courier_phone;

CREATE TABLE if not exists patent_office_accounts (
  account_id int(11) NOT NULL AUTO_INCREMENT,
  user int(11) NOT NULL COMMENT '用户id',
  name varchar(200) DEFAULT NULL COMMENT '电子用户名',
  username varchar(100) NOT NULL COMMENT '电子代码',
  password varchar(100) NOT NULL COMMENT '电子登录密码',
  patent_update_time datetime DEFAULT NULL COMMENT '专利更新时间',
  PRIMARY KEY (`account_id`),
  CONSTRAINT `fk_patent_office_account_users` FOREIGN KEY (`user`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

ALTER TABLE patents ADD COLUMN publish_date DATE;
ALTER TABLE patents ADD COLUMN publish_no VARCHAR(30);
ALTER TABLE patents ADD COLUMN proxy_org VARCHAR(100);

ALTER TABLE users ADD COLUMN visible_password VARCHAR(100);


INSERT INTO groups VALUES(3, 'TRADER');
INSERT INTO group_authorities VALUES (3, 'ROLE_TRADER');

ALTER TABLE user_patents ADD COLUMN trash_status INT  DEFAULT 1;
ALTER TABLE patents ADD COLUMN transaction_status VARCHAR(10);

alter table friends add column remark_name varchar(50);

ALTER TABLE patents ADD COLUMN  create_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间';

ALTER TABLE contact_addresses DROP FOREIGN KEY  fk_contact_addresses_street; 

ALTER TABLE contact_addresses DROP COLUMN street; 


CREATE TABLE IF NOT EXISTS patent_remarks (
	remark_id INT AUTO_INCREMENT PRIMARY KEY  ,
	create_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP ,
	content  VARCHAR(1000),
	patent_id BIGINT NOT NULL,
	user_id INT NOT NULL,
	CONSTRAINT fk_patent_remarks_patent_id FOREIGN KEY idx_fk_patent_remarks_patent_id (patent_id) REFERENCES patents(patent_id) , 
	CONSTRAINT fk_patent_remarks_user_id FOREIGN KEY idx_fk_patent_remarks_user_id (user_id) REFERENCES users(user_id) 
);

CREATE TABLE  IF NOT EXISTS patent_documents (
  patent_doc_id bigint(20) NOT NULL AUTO_INCREMENT,
  app_no varchar(30) DEFAULT NULL,
  user_id int(11) DEFAULT NULL,
  patent_type int(11) NOT NULL COMMENT '专利类型',
  create_time date DEFAULT NULL COMMENT '专利创建时间',
  last_update_time timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '专利更新时间',
  patent_name varchar(1000) DEFAULT NULL COMMENT '专利名称',
  manual mediumtext COMMENT '说明书',
  right_claim mediumtext COMMENT '权利要求',
  abstract_desc mediumtext COMMENT '摘要',
  abstract_img varchar(200) DEFAULT NULL COMMENT '摘要附图',
  patent_doc_attachment_file varchar(200) DEFAULT NULL COMMENT '上传附件保存地址',
  patent_doc_status int NOT NULL COMMENT '文档状态',
  patent_doc_url VARCHAR(200) default null COMMENT '文档保存地址',
  contact_id int COMMENT '联系人编号',
  price BIGINT DEFAULT NULL COMMENT '文档价格',
  attachment_url VARCHAR(100) COMMENT '请求书上传文件地址';
  other_information VARCHAR(1000) COMMENT '其他信息';
  patent_doc_proxy_status int NOT NULL COMMENT '代理状态',
  attachment_url VARCHAR(100) COMMENT '请求书上传文件地址';
  other_information VARCHAR(1000) COMMENT '其他信息';
  PRIMARY KEY (patent_doc_id),
  KEY fk_patent_documents_patent_type (patent_type),
  KEY fk_patent_documents_doc_owner_id (user_id),
  CONSTRAINT fk_patent_documents_doc_owner_id FOREIGN KEY (user_id) REFERENCES users (user_id),
  CONSTRAINT fk_patent_documents_patent_type FOREIGN KEY (patent_type) REFERENCES patent_types (patent_type_id),
  constraint fk_patent_documents_status foreign key idx_fk_patent_doc_status (patent_doc_status) references patent_doc_status(patent_doc_status_id),
   constraint fk_patent_documents_proxy_status foreign key idx_fk_patent_doc_proxy_status (patent_doc_proxy_status) references patent_doc_proxy_status(patent_doc_proxy_status_id)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8;


CREATE TABLE IF NOT EXISTS patent_doc_section_types(
	patent_doc_section_id INT PRIMARY KEY,
	patent_doc_section_desc VARCHAR(10) NOT NULL COMMENT '专利主题'
	
);

INSERT INTO patent_doc_section_types VALUES(1,'说明书');
INSERT INTO patent_doc_section_types VALUES(2,'权利要求');
INSERT INTO patent_doc_section_types VALUES(3,'摘要');

CREATE TABLE IF NOT EXISTS patent_document_templates(
	template_id INT AUTO_INCREMENT PRIMARY KEY,
	content mediumtext NULL COMMENT '专利模块部分',
	template_title VARCHAR(400) NOT NULL COMMENT '模板说明',
	patent_type INT NOT NULL COMMENT '专利类型',
	patent_doc_section INT NOT NULL COMMENT '专利主题',
	create_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
	last_update_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT'最近修改时间',
	creator_id INT NOT NULL COMMENT '创建者',
	CONSTRAINT fk_patent_document_template_patent_type FOREIGN KEY ids_fk_patent_name_template_patent_type(patent_type) REFERENCES patent_types(patent_type_id),
	CONSTRAINT fk_patent_document_template_creator_id FOREIGN KEY ids_fk_patent_name_template_creator_id(creator_id) REFERENCES users(user_id),
	CONSTRAINT fk_patent_document_template_patent_doc_section FOREIGN KEY ids_fk_patent_document_template_doc_section(patent_doc_section) REFERENCES patent_doc_section_types(patent_doc_section_id)
	
);


CREATE TABLE IF NOT EXISTS patent_attachment (
  attachment_id BIGINT NOT NULL AUTO_INCREMENT,
  attachment_url VARCHAR(200) DEFAULT NULL,
  patent_doc_id BIGINT,
  caption VARCHAR(200) NOT NULL COMMENT '说明',
  seq_no int NOT NULL COMMENT '图片序列号',
  PRIMARY KEY (attachment_id),
  CONSTRAINT fk_patent_documents_doc_id FOREIGN KEY idx_fk_patent_documents_doc_id(patent_doc_id) REFERENCES patent_documents(patent_doc_id) on delete cascade
);




INSERT INTO groups
VALUES
	(4, 'PROXY_ORG'),	
	(5, 'CUSTOMER_SUPPORT'),
	(6, 'TECH'),
	(7, 'PROCESS');

INSERT INTO group_authorities
VALUES
	(4, 'ROLE_PROXY_ORG'),	
	(5, 'ROLE_CUSTOMER_SUPPORT'),
	(6, 'ROLE_TECH'),
	(7, 'ROLE_PROCESS');
	
INSERT INTO group_members(username,group_id) VALUES('test',4);

CREATE TABLE IF NOT EXISTS customer_supports (
	id INT NOT NULL AUTO_INCREMENT UNIQUE,
	user_id INT NOT NULL,
	proxy_org_id INT NOT NULL,
	remark_name VARCHAR(30) ,
	PRIMARY KEY (user_id,proxy_org_id),	
	CONSTRAINT fk_customer_supports_user_id FOREIGN KEY(user_id) REFERENCES users(user_id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS tech_person (
	id INT NOT NULL AUTO_INCREMENT UNIQUE,
	user_id INT NOT NULL,
	proxy_org_id INT NOT NULL,
	remark_name VARCHAR(30) ,
	PRIMARY KEY(user_id,proxy_org_id),	
	CONSTRAINT fk_tech_person_user_id FOREIGN KEY(user_id) REFERENCES users(user_id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS process_person (
	id INT NOT NULL AUTO_INCREMENT UNIQUE,
	user_id INT NOT NULL,
	proxy_org_id INT NOT NULL,
	remark_name VARCHAR(30) ,
	PRIMARY KEY(user_id,proxy_org_id),	
	CONSTRAINT fk_process_person_user_id FOREIGN KEY(user_id) REFERENCES users(user_id) ON DELETE CASCADE
);


CREATE TABLE IF NOT EXISTS common_app_person (
  app_person_id BIGINT NOT NULL AUTO_INCREMENT,
  NAME VARCHAR(20) NOT NULL  COMMENT'申请人姓名',
  id_number  VARCHAR(20) NOT NULL  COMMENT '证件号码',
  postcode_address VARCHAR(200) NOT NULL  COMMENT '邮编及地址',
  other_information VARCHAR(50) DEFAULT NULL COMMENT '其他信息',
  user_id INT(11)  NOT NULL,
  proxy_file  VARCHAR(200) DEFAULT NULL COMMENT '上传委托书保存地址',
  transaction_identity_id  VARCHAR(50) DEFAULT NULL COMMENT '备案证件号',
  fee_reduce_transaction_status  VARCHAR(20) DEFAULT '未备案' NOT NULL  COMMENT '费减备案',
  transaction_year  VARCHAR(20) DEFAULT NULL COMMENT '备案年度',
  app_person_attachment_file  VARCHAR(200) DEFAULT NULL COMMENT '上传附件保存地址',
  PRIMARY KEY(app_person_id),
  KEY fk_common_app_person_owner_id (user_id),
  CONSTRAINT fk_common_app_person_owner_id FOREIGN KEY(user_id) REFERENCES users (user_id) ON   DELETE   CASCADE   ON   UPDATE   CASCADE 
);

CREATE TABLE IF NOT EXISTS common_inventor (
  inventor_id BIGINT NOT NULL AUTO_INCREMENT,
  inventor_name VARCHAR(20) NOT NULL COMMENT'发明姓名',
  inventor_id_number  VARCHAR(20) DEFAULT NULL COMMENT '证件号码',
  inventor_nationality VARCHAR(20) DEFAULT NULL COMMENT '发明人国籍',
  inventor_mobile varchar(40) DEFAULT NULL COMMENT '电话号码',
  inventor_email VARCHAR(40) DEFAULT NULL COMMENT '邮箱' ,
  inventor_other_information VARCHAR(50) DEFAULT NULL COMMENT '其他信息',
  inventor_attachment_file  VARCHAR(200) DEFAULT NULL COMMENT '上传附件保存地址',
  user_id INT(11)  NOT NULL ,
  PRIMARY KEY(inventor_id),
  KEY fk_common_inventor_owner_id (user_id),
  CONSTRAINT fk_common_inventor_owner_id FOREIGN KEY(user_id) REFERENCES users (user_id) 
  
);	

CREATE TABLE IF NOT EXISTS user_inventor(
  USER INT(11) NOT NULL DEFAULT '0',
  inventor BIGINT(20) NOT NULL DEFAULT '0',
  PRIMARY KEY (`user`,`inventor`),
  KEY `fk_user_inventor` (`inventor`),
  CONSTRAINT `fk_share_inventor` FOREIGN KEY (inventor) REFERENCES `common_inventor` (inventor_id) ON DELETE CASCADE,
  CONSTRAINT `fk_user_inventor_user` FOREIGN KEY (USER) REFERENCES `users` (user_id) ON DELETE CASCADE
) ENGINE=INNODB DEFAULT CHARSET=utf8;



CREATE TABLE IF NOT EXISTS user_app_person (
  USER INT(11) NOT NULL DEFAULT '0',
  app_person BIGINT(20) NOT NULL DEFAULT '0',
  trash_status INT(11) DEFAULT '1',
  PRIMARY KEY (`user`,`app_person`),
  KEY `fk_user_app_person` (`app_person`),
  CONSTRAINT `fk_share_app_person_person` FOREIGN KEY (app_person) REFERENCES `common_app_person` (app_person_id) ON DELETE CASCADE,
  CONSTRAINT `fk_user_app_person_user` FOREIGN KEY (USER) REFERENCES `users` (user_id) ON DELETE CASCADE
) ENGINE=INNODB DEFAULT CHARSET=utf8;



 CREATE TABLE IF NOT EXISTS patent_doc_app_person(
	person_id BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	patent_doc_id BIGINT NOT NULL COMMENT '文档编号',
	NAME VARCHAR(20) NOT  NULL COMMENT '申请人姓名',
	id_number VARCHAR(20) NOT NULL COMMENT '申请人身份证编号',
	postcode_address VARCHAR(300) NOT  NULL COMMENT'邮编地址',
	other_information VARCHAR(50) COMMENT'其他信息',
	transaction_identity  VARCHAR(50) DEFAULT NULL COMMENT '备案证件号',
	fee_reduce_transaction_status  VARCHAR(20) DEFAULT '未备案' COMMENT '费减备案',
  	transaction_year  VARCHAR(20) DEFAULT NULL COMMENT '备案年度',
	user_id INT NOT NULL COMMENT'创建者编号',
	CONSTRAINT fk_patent_doc_app_person_doc_id FOREIGN KEY idx_fk_patent_doc_app_person_doc_id(patent_doc_id) REFERENCES patent_documents(patent_doc_id) ON   DELETE   CASCADE

)ENGINE=INNODB DEFAULT CHARSET=utf8;


CREATE TABLE IF NOT EXISTS proxy_org (
	org_id INT PRIMARY KEY  AUTO_INCREMENT ,
	org_user_id INT NOT NULL,
	remark_name VARCHAR(30) ,
	parent_org_id INT ,
	UNIQUE(org_user_id,parent_org_id),	
	CONSTRAINT fk_proxy_org_parent_org_id FOREIGN KEY(parent_org_id) REFERENCES proxy_org(org_id), 
    CONSTRAINT fk_proxy_org_org_user_id FOREIGN KEY(org_user_id) REFERENCES users(user_id) ON DELETE CASCADE
)ENGINE=INNODB DEFAULT CHARSET=utf8;

INSERT INTO proxy_org(org_user_id) VALUES (2);


CREATE TABLE IF NOT EXISTS notice_remarks (
	remark_id INT AUTO_INCREMENT PRIMARY KEY  ,
	create_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP ,
	content  VARCHAR(1000),
	notice_id BIGINT NOT NULL,
	user_id INT NOT NULL,
	CONSTRAINT fk_notice_remarks_notice_id FOREIGN KEY(notice_id) REFERENCES notices(notice_id) , 
	CONSTRAINT fk_notice_remarks_user_id FOREIGN KEY (user_id) REFERENCES users(user_id)	
);

CREATE TABLE IF NOT EXISTS patent_doc_status (
	patent_doc_status_id INT AUTO_INCREMENT PRIMARY KEY,
	patent_doc_status_desc VARCHAR(10) NOT NULL UNIQUE
);

INSERT INTO patent_doc_status (patent_doc_status_id, patent_doc_status_desc)
VALUES
	(1, '草稿'),
	(2, '立案分配'),
	(3, '已分配'),
	(4, '专家撰写'),
	(5, '待确认'),
	(6, '待修改'),
	(7, '定稿'),
	(8, '撰写完成'),
	(9, '待交局'),
	(10, '已交局');

CREATE TABLE IF NOT EXISTS user_patent_docs (
	user_id INT,
	patent_doc BIGINT,
	CONSTRAINT pk_user_patent_docs PRIMARY KEY (user_id, patent_doc),
	CONSTRAINT fk_user_patent_doc_user FOREIGN KEY idx_fk_user_patent_doc_user (user_id) REFERENCES users(user_id) ON DELETE CASCADE,
	CONSTRAINT fk_user_patent_docs_patent_docs FOREIGN KEY idx_fk_user_patent_docs_patent_docs (patent_doc) REFERENCES patent_documents(patent_doc_id) ON DELETE CASCADE
);
CREATE TABLE patent_doc_inventor(
     inventor_id BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
     patent_doc_id BIGINT NOT NULL COMMENT '文档编号',
     inventor_name VARCHAR(200) NOT NULL COMMENT '发明人姓名',
     inventor_number VARCHAR(20) NOT NULL COMMENT '省份证编号',
     inventor_nationality VARCHAR(100) NOT NULL COMMENT '国籍',
     inventor_mobile INT  NOT NULL COMMENT '联系电话',
     inventor_email VARCHAR(100) NOT NULL COMMENT '邮箱',
     inventor_other_information VARCHAR(50) COMMENT '其他信息',
     user_id INT COMMENT '创建者',
     CONSTRAINT fk_patent_doc_inventor_patent_doc_id FOREIGN KEY idx_patent_doc_inventor_patent_doc_id(patent_doc_id) REFERENCES patent_documents(patent_doc_id) ON DELETE CASCADE,
     CONSTRAINT fk_patent_doc_inventor_user_id FOREIGN KEY idx_patent_doc_inventor_user_id(user_id) REFERENCES users(user_id) ON DELETE CASCADE
     

)ENGINE=INNODB DEFAULT CHARSET=utf8;

ALTER TABLE common_inventor MODIFY  inventor_mobile VARCHAR(40) ;
ALTER TABLE common_inventor MODIFY  inventor_email VARCHAR(40) ;

ALTER TABLE common_app_person MODIFY COLUMN id_number VARCHAR(20) NOT NULL ;
ALTER TABLE common_app_person MODIFY COLUMN NAME VARCHAR(20) NOT NULL;
ALTER TABLE common_app_person MODIFY COLUMN postcode_address VARCHAR(50) NOT NULL;
ALTER TABLE common_app_person MODIFY COLUMN fee_reduce_transaction_status VARCHAR(20) DEFAULT '未备案' NOT NULL;

ALTER TABLE common_inventor MODIFY COLUMN inventor_name VARCHAR(20) NOT NULL;

create table if not exists patent_doc_orders (
	order_id bigint primary key auto_increment,
	order_status int not null default 0,
	last_update_time timestamp default current_timestamp on update current_timestamp not null,
	amount int not null,
	user int not null,
	create_time timestamp not null,
	pay_time timestamp ,
	payment_method int,
	constraint fk_patent_doc_orders_user foreign key(user) references users(user_id),
	constraint fk_patent_doc_orders_payment_method foreign key(payment_method) references payment_methods(payment_method_id)
) auto_increment=333333;

CREATE TABLE IF NOT EXISTS patent_doc_order_items (
	item_id BIGINT PRIMARY KEY AUTO_INCREMENT,
	order_id BIGINT NOT NULL,
	patent_doc_id BIGINT NOT NULL,
	UNIQUE KEY uk_order_items_order_fee (order_id, patent_doc_id),
	CONSTRAINT fk_patent_doc_order_items_order FOREIGN KEY(order_id) REFERENCES patent_doc_orders(order_id) ON DELETE CASCADE,
	CONSTRAINT fk_patent_doc_order_items_patent_documents FOREIGN KEY(patent_doc_id) REFERENCES patent_documents(patent_doc_id)
);

CREATE TABLE IF NOT EXISTS patent_doc_workflow_action(
	action_id INT(11) NOT NULL PRIMARY KEY AUTO_INCREMENT,
	action_type_desc VARCHAR(30) DEFAULT NULL
)ENGINE=INNODB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS patent_doc_workflow_history(
	history_id BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	patent_doc_id BIGINT NOT NULL COMMENT '文档编号',
	user_id INT NOT NULL COMMENT '创建者',
	user_name VARCHAR(50) ,
	ACTION INT NOT NULL COMMENT'操作',
	action_time TIMESTAMP NOT NULL COMMENT '操作创建时间',
	CONSTRAINT fk_patent_doc_workflow_history_user_id FOREIGN KEY idx_patent_doc_workflow_history_user_id(user_id) REFERENCES users(user_id) ON DELETE CASCADE,
	CONSTRAINT fk_patent_doc_workflow_history_patent_doc_id FOREIGN KEY idx_patent_doc_workflow_history_patent_doc_id(patent_doc_id) REFERENCES
	patent_documents(patent_doc_id) ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT fk_patent_doc_workflow_history_action FOREIGN KEY idx_patent_doc_workflow_history_action(ACTION) REFERENCES
	 patent_doc_workflow_action (action_id) ON DELETE CASCADE
)ENGINE=INNODB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS patent_doc_workflow_target (
	history BIGINT NOT NULL  COMMENT '历史记录',
	target INT NOT NULL COMMENT '操作目标对象',
	user_name VARCHAR(50) COMMENT '姓名',
	patent_doc BIGINT NOT NULL COMMENT '文档',
	PRIMARY KEY (history,target,patent_doc),
	KEY fk_target_patent_doc_patent_doc(patent_doc),
	CONSTRAINT `fk_patent_doc_workflow_target_patent_doc` FOREIGN KEY (`patent_doc`) REFERENCES `patent_documents` (`patent_doc_id`) ON DELETE CASCADE,
	CONSTRAINT `fk_patent_doc_workflow_target_target` FOREIGN KEY (`target`) REFERENCES `users` (`user_id`) ON DELETE CASCADE,
	CONSTRAINT fk_patent_doc_workflow_target_history FOREIGN KEY (history) REFERENCES patent_doc_workflow_history(history_id) ON DELETE CASCADE
) ENGINE=INNODB DEFAULT CHARSET=utf8;

insert into groups (id,group_name) values (8,'PLATFORM');
insert into group_authorities (group_id,authority) values (8,'ROLE_PLATFORM');


INSERT INTO patent_doc_workflow_action(action_id,action_type_desc)VALUES(1,'委托给平台账户');
INSERT INTO patent_doc_workflow_action(action_id,action_type_desc)VALUES(2,'分配给代理机构');
INSERT INTO patent_doc_workflow_action(action_id,action_type_desc)VALUES(3,'分配给客服人员');
INSERT INTO patent_doc_workflow_action(action_id,action_type_desc)VALUES(4,'分配给技术员');
INSERT INTO patent_doc_workflow_action(action_id,action_type_desc)VALUES(5,'置为待修改');
INSERT INTO patent_doc_workflow_action(action_id,action_type_desc)VALUES(6,'保存或修改');
INSERT INTO patent_doc_workflow_action(action_id,action_type_desc)VALUES(7,'定稿');
INSERT INTO patent_doc_workflow_action(action_id,action_type_desc)VALUES(8,'制作标准文件');
INSERT INTO patent_doc_workflow_action(action_id,action_type_desc)VALUES(9,'确认');
INSERT INTO patent_doc_workflow_action(action_id,action_type_desc)VALUES(10,'交局');
INSERT INTO patent_doc_workflow_action(action_id,action_type_desc)VALUES(11,'分配给流程人员');
INSERT INTO patent_doc_workflow_action(action_id,action_type_desc)VALUES(12,'删除');
INSERT INTO patent_doc_workflow_action(action_id,action_type_desc)VALUES(13,'置为待确认');
INSERT INTO patent_doc_workflow_action(action_id,action_type_desc)VALUES(14,'置为待交局');
INSERT INTO patent_doc_workflow_action(action_id,action_type_desc) VALUES(15,'拒绝委托');
INSERT INTO patent_doc_workflow_action(action_id,action_type_desc) VALUES(16,'上传交局文件');
INSERT INTO patent_doc_workflow_action(action_id,action_type_desc) VALUES(18,'上传定稿文件');
REPLACE INTO patent_doc_workflow_action(action_id,action_type_desc) VALUES(17,'分享给好友');


CREATE TABLE `share_patent_docs` (
  `patent_doc` BIGINT(20) NOT NULL DEFAULT '0',
  `share_by` INT(11) NOT NULL DEFAULT '0',
  `share_to` INT(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`patent_doc`,`share_by`,`share_to`),
  KEY `fk_share_patent_docs_share_by` (`share_by`),
  KEY `fk_share_patent_docs_share_to` (`share_to`),
  CONSTRAINT `fk_share_patent_docs_patent` FOREIGN KEY (`patent_doc`) REFERENCES `patent_documents` (`patent_doc_id`) ON DELETE CASCADE,
  CONSTRAINT `fk_share_patent_docs_share_by` FOREIGN KEY (`share_by`) REFERENCES `users` (`user_id`) ON DELETE CASCADE,
  CONSTRAINT `fk_share_patent_docs_share_to` FOREIGN KEY (`share_to`) REFERENCES `users` (`user_id`) ON DELETE CASCADE
) ENGINE=INNODB DEFAULT CHARSET=utf8;


CREATE TABLE IF NOT EXISTS patent_doc_proxy_status (
	patent_doc_proxy_status_id INT AUTO_INCREMENT PRIMARY KEY,
	patent_doc_proxy_status_desc VARCHAR(10) NOT NULL UNIQUE
);

INSERT INTO patent_doc_proxy_status (patent_doc_proxy_status_id, patent_doc_proxy_status_desc)
VALUES
	(1, '未委托'),
	(2, '已支付'),
	(3, '已委托'),
	(4, '已取消');
	
ALTER TABLE patent_documents ADD COLUMN internal_code VARCHAR(100) COMMENT '内部编码';

ALTER TABLE patent_doc_order_items ADD COLUMN apply_fee INT NOT NULL DEFAULT 0 COMMENT '申请费';
ALTER TABLE patent_doc_order_items ADD COLUMN print_fee INT NOT NULL DEFAULT 0 COMMENT '打印费';
ALTER TABLE patent_doc_order_items ADD COLUMN check_fee INT NOT NULL DEFAULT 0 COMMENT '审查费';
ALTER TABLE patent_doc_order_items ADD COLUMN service_fee INT NOT NULL DEFAULT 0 COMMENT '服务费';

ALTER TABLE patent_documents ADD COLUMN invoice_pic VARCHAR(200) DEFAULT NULL COMMENT '缴费发票凭证';
INSERT INTO payment_methods VALUES(3, '缴费凭证支付');

ALTER TABLE patent_doc_app_person ADD COLUMN proxy_file VARCHAR(200) COMMENT '委托书文件地址';
ALTER TABLE patent_doc_app_person ADD COLUMN app_person_attachment_file VARCHAR(200) COMMENT '附件存放地址';
ALTER TABLE patent_doc_inventor ADD COLUMN inventor_attachment_file VARCHAR(200) COMMENT '附件存放地址';s

alter table patent_documents add column app_date date comment '申请日';
UPDATE fee_payment_status SET fee_payment_status_desc='订单完成' WHERE fee_payment_status_id=5;
UPDATE order_status SET status_description='订单完成' WHERE order_status_id=3;

ALTER TABLE patent_documents ADD COLUMN patent_doc_status_text VARCHAR(150) COMMENT '案件状态描述';

INSERT INTO patent_doc_status(patent_doc_status_id,patent_doc_status_desc)
VALUES(20,'等待申请费'),
(21,'待答复'),
(22,'等年登印费'),
(23,'待恢复'),
(24,'失效'),
(25,'专利权维持'),
(26,'其他');

ALTER TABLE common_inventor add COLUMN create_time  TIMESTAMP;
ALTER TABLE common_app_person add COLUMN create_time TIMESTAMP;


CREATE TABLE IF NOT EXISTS notice_read (
	notice_id BIGINT NOT NULL,
	user_id INT NOT NULL,
	PRIMARY KEY (notice_id,user_id)
);

CREATE TABLE if not exists `user_fees` (
  `user` INT(11) NOT NULL DEFAULT '0',
  `fee` BIGINT(20) NOT NULL DEFAULT '0',
  PRIMARY KEY (`user`,`fee`),
  KEY `fk_user_fee_fee` (`fee`),
  CONSTRAINT `fk_user_fee_fee` FOREIGN KEY (`fee`) REFERENCES `fees` (`fee_id`) ON DELETE CASCADE,
  CONSTRAINT `fk_user_fee_user` FOREIGN KEY (`user`) REFERENCES `users` (`user_id`) ON DELETE CASCADE
) ENGINE=INNODB DEFAULT CHARSET=utf8;


ALTER TABLE common_app_person MODIFY COLUMN other_information VARCHAR(1000);
ALTER TABLE patent_doc_app_person COLUMN other_information VARCHAR(1000);
ALTER TABLE users ADD COLUMN qq varchar(20);
ALTER TABLE users ADD COLUMN weChat VARCHAR(150);
ALTER TABLE users ADD COLUMN avatar_url VARCHAR(500);

alter table patent_doc_app_person modify column name varchar(200);


ALTER TABLE common_app_person MODIFY NAME VARCHAR(200);
ALTER TABLE common_inventor MODIFY inventor_name VARCHAR(200);

create table if not exists express_status(
	express_status_id int primary key auto_increment,
	express_status_desc varchar(30)
);

CREATE TABLE express (
  express_id bigint(20) NOT NULL AUTO_INCREMENT,
  sender int(11) NOT NULL,
  receiver int(11) NOT NULL,
  express_remark varchar(500) DEFAULT NULL,
  province int(11) NOT NULL,
  city bigint(20) NOT NULL,
  district bigint(20) NOT NULL,
  detail_address varchar(100) NOT NULL,
  express_company varchar(100) NOT NULL,
  express_no varchar(50) NOT NULL,
  create_time timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  send_time date,
  sign_time datetime,
  express_status int(11) NOT NULL DEFAULT '1',
  phone varchar(20) DEFAULT NULL COMMENT '联系电话或手机号码',
  contact_person varchar(200) NOT NULL,
  PRIMARY KEY (express_id),
  KEY fk_express_sender (sender),
  KEY fk_express_receiver (receiver),
  KEY fk_express_province (province),
  KEY fk_express_city (city),
  KEY fk_express_district (district),
  KEY fk_express_express_status (express_status),
  CONSTRAINT fk_express_city FOREIGN KEY (city) REFERENCES cities (id),
  CONSTRAINT fk_express_district FOREIGN KEY (district) REFERENCES districts (id),
  CONSTRAINT fk_express_express_status FOREIGN KEY (express_status) REFERENCES express_status (express_status_id),
  CONSTRAINT fk_express_province FOREIGN KEY (province) REFERENCES provinces (id),
  CONSTRAINT fk_express_receiver FOREIGN KEY (receiver) REFERENCES users (user_id),
  CONSTRAINT fk_express_sender FOREIGN KEY (sender) REFERENCES users (user_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO express_status(express_status_id,express_status_desc) VALUES (1,'草稿');
INSERT INTO express_status(express_status_id,express_status_desc) VALUES (2,'待签收');
INSERT INTO express_status(express_status_id,express_status_desc) VALUES (3,'已签收');

ALTER TABLE common_app_person ADD COLUMN phone VARCHAR(30) COMMENT '联系人手机号码';
<<<<<<< HEAD
ALTER TABLE common_app_person ADD COLUMN is_fee_reduce int DEFAULT '1' COMMENT '是否为费减备案状态';
UPDATE common_app_person SET is_fee_redurce=2;
=======
ALTER TABLE common_app_person ADD COLUMN is_fee_redurce int DEFAULT '1' COMMENT '是否为费减备案状态';
UPDATE common_app_person SET is_fee_reduce=2;
>>>>>>> 7fb148666b61dfc946d908c7fc6d4c2cd259f9fd

