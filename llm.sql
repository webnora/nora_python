CREATE TABLE corpus (
	id INTEGER NOT NULL, 
	name VARCHAR NOT NULL, 
	PRIMARY KEY (id)
);
CREATE TABLE doc (
	id INTEGER NOT NULL, 
	name VARCHAR NOT NULL, 
	corpus_id INTEGER NOT NULL, 
	PRIMARY KEY (id), 
	FOREIGN KEY(corpus_id) REFERENCES corpus (id)
);
CREATE TABLE line (
	id INTEGER NOT NULL, 
	doc_id INTEGER NOT NULL, 
	PRIMARY KEY (id), 
	FOREIGN KEY(doc_id) REFERENCES doc (id)
);
CREATE TABLE form (
	id INTEGER NOT NULL, 
	line_id INTEGER NOT NULL, 
	num INTEGER NOT NULL, 
	form VARCHAR NOT NULL, 
	lemma VARCHAR NOT NULL, 
	PRIMARY KEY (id), 
	FOREIGN KEY(line_id) REFERENCES line (id)
);
CREATE TABLE model (
	id INTEGER NOT NULL, 
	name VARCHAR NOT NULL, 
	PRIMARY KEY (id)
);
CREATE TABLE predict (
	id INTEGER NOT NULL, 
	model_id INTEGER NOT NULL, 
	line_id INTEGER NOT NULL, 
	done BOOLEAN NOT NULL, 
	no_eq INTEGER NOT NULL, 
	at DATETIME NOT NULL, 
	load_duration INTEGER NOT NULL, 
	prompt_eval_duration INTEGER NOT NULL, 
	eval_duration INTEGER NOT NULL, 
	prompt_tokens INTEGER NOT NULL, 
	completion_tokens INTEGER NOT NULL, 
	temperature FLOAT NOT NULL, 
	PRIMARY KEY (id), 
	FOREIGN KEY(model_id) REFERENCES model (id), 
	FOREIGN KEY(line_id) REFERENCES line (id)
);
CREATE TABLE predictraw (
	id INTEGER NOT NULL, 
	promt VARCHAR NOT NULL, 
	content VARCHAR NOT NULL, 
	forms VARCHAR NOT NULL, 
	lemmas VARCHAR NOT NULL, 
	tool_calls VARCHAR, 
	PRIMARY KEY (id), 
	FOREIGN KEY(id) REFERENCES predict (id)
);
CREATE TABLE llm (
	id INTEGER NOT NULL, 
	predict_id INTEGER NOT NULL, 
	form_id INTEGER NOT NULL, 
	lemma VARCHAR NOT NULL, 
	eq BOOLEAN NOT NULL, 
	PRIMARY KEY (id), 
	FOREIGN KEY(predict_id) REFERENCES predict (id), 
	FOREIGN KEY(form_id) REFERENCES form (id)
);
CREATE TABLE llmraw (
	id INTEGER NOT NULL, 
	en VARCHAR NOT NULL, 
	ru VARCHAR NOT NULL, 
	morph VARCHAR NOT NULL, 
	syntax VARCHAR NOT NULL, 
	raw VARCHAR NOT NULL, 
	PRIMARY KEY (id), 
	FOREIGN KEY(id) REFERENCES llm (id)
);