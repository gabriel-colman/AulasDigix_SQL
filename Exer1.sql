create table aluno (
    idt int primary key not null,
    des_nome varchar (255),
    num_grau int
);

create table amigo (
    idt_amigo1 int,
    idt_amigo2 int,
    foreign key(idt_amigo1) references aluno(idt),
    foreign key(idt_amigo2) references aluno(idt)
);

create table curtida (
    idt_amigo1 int,
    idt_amigo2 int,
    foreign key(idt_amigo1) references aluno(idt),
    foreign key(idt_amigo2) references aluno(idt)
);