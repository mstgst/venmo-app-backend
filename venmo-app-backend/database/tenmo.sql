BEGIN TRANSACTION;

DROP TABLE IF EXISTS tenmo_user, account, transfer;

DROP SEQUENCE IF EXISTS seq_user_id, seq_account_id, seq_transfer_id;

-- Sequence to start user_id values at 1001
CREATE SEQUENCE seq_user_id
  INCREMENT BY 1
  START WITH 1001
  NO MAXVALUE;

CREATE TABLE tenmo_user (
	user_id int NOT NULL DEFAULT nextval('seq_user_id'),
	username varchar(50) NOT NULL,
	password_hash varchar(200) NOT NULL,
	CONSTRAINT PK_tenmo_user PRIMARY KEY (user_id),
	CONSTRAINT UQ_username UNIQUE (username)
);

-- Sequence to start account_id values at 2001
CREATE SEQUENCE seq_account_id
  INCREMENT BY 1
  START WITH 2001
  NO MAXVALUE;

CREATE TABLE account (
	account_id int NOT NULL DEFAULT nextval('seq_account_id'),
	user_id int NOT NULL,
	balance decimal(13, 2) NOT NULL,
	CONSTRAINT PK_account PRIMARY KEY (account_id),
	CONSTRAINT FK_account_tenmo_user FOREIGN KEY (user_id) REFERENCES tenmo_user (user_id)
);

-- Sequence to start transfer_id
CREATE SEQUENCE seq_transfer_id
  INCREMENT BY 1
  START WITH 1000001
  NO MAXVALUE;

CREATE TABLE transfer (
    transfer_id int NOT NULL DEFAULT nextval('seq_transfer_id'),
	amount decimal(13,2) NOT NULL,
	sender_id int NOT NULL,
	receiver_id int NOT NULL,
	CONSTRAINT PK_transfer PRIMARY KEY(transfer_id),
    CONSTRAINT FK_sender_account FOREIGN KEY(sender_id) REFERENCES account(account_id),
    CONSTRAINT FK_receiver_account FOREIGN KEY(receiver_id) REFERENCES account(account_id)
);

COMMIT;
