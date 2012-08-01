EXEC = main

$(EXEC): types.cmo transform.cmo parser.cmo parser.cmi lexer.cmo data.cmo main.cmo
	ocamlc -o $@ string2.cma str.cma types.cmo transform.cmo parser.cmo lexer.cmo data.cmo main.cmo

%.cmi: %.mli
	ocamlc $^

%.cmo: %.ml
	ocamlc $^ -c

data.cmo: data.cmi data.ml
	ocamlc data.ml -c

parser.ml: parser.mly
	ocamlyacc $^
	ocamlc $@i

lexer.ml: lexer.mll
	ocamllex $^

test: $(EXEC)
#	./$^ -i ../Data/contrib.sql
#	./$^ -i ../Data/contrib_rels_note.sql
#	./$^ -i ../Data/contrib_rels_subject.sql
#	./$^ -i ../Data/contrib_rels_term.sql
#	./$^ -i ../Data/event.sql
#	./$^ -i ../Data/event_rels.sql
#	./$^ -i ../Data/language_rels.sql
#	./$^ -i ../Data/nationality.sql
#	./$^ -i ../Data/place.sql
#	./$^ -i ../Data/ptype_role.sql
#	./$^ -i ../Data/ptype_role_rels.sql
#	./$^ -i ../Data/revision_history.sql
#	./$^ -i ../Data/revision_history_source.sql
#	./$^ -i ../Data/scope_notes.sql
#	./$^ -i ../Data/source.sql
#	./$^ -i ../Data/source_rels_note.sql
#	./$^ -i ../Data/source_rels_subject.sql
#	./$^ -i ../Data/source_rels_term.sql
#	./$^ -i ../Data/subject.sql
#	./$^ -i ../Data/subject_rels.sql
#	./$^ -i ../Data/term.sql
	./$^ -i examples/tables.sql

clean:
	rm -rf *.cm* $(EXEC) *~ \#*\# *.owl parser.ml lexer.ml parser.mli
