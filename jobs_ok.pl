%Steve McLaughlin 
%Prolog Assignment

%jobs_ok(+Assignment, +Employees)
%Assignment is a list of four sublists, one for each shift
%Employees is a list of sublists containing names and skills
%succeed when acceptable 

jobs_ok(Shift, Skill) :-
				 shift_ok(Shift),
				 has_skill(Shift, Skill).				

%isUnique(+Value, +List)
%this predicate checks whether the value is unique in the list		
isUnique(_, []).
isUnique(Value, [H|T]) :-
			Value\== H,
			isUnique(Value, T).

%singleList(+L, +L2, +L3, +L4)
%this predicate takes the components of the shifts list
%and merges them into one single list to process
singleList(L, L2, L3, L4) :-  append(L, L2, X),
				append(X, L3, Y),
				append(Y, L4, Z),
				isOkay(Z).

%isOkay(+L)
%this predicate searches all of the shifts to find any duplicates
isOkay([]).
isOkay([H|T]) :- isUnique(H, T),
		 isOkay(T).

%shift_ok(+L)
%this predicate splits the shifts list up into its components
shift_ok([A, B, C, D]) :- singleList(A, B, C, D).	

%has_Skill(+L, +L2)
%breaks shifts apart, processes individually against the skill list
has_skill([A, B, C, D], L) :- skills(A, L),
			      skills(B, L),
                              skills(C, L),
                              skills(D, L).

%skills(+L, +L2)
%breaks individual shifts into jobs then checks them against the skill list
skills([A, B, C, D], Skill) :-
				phone(A, Skill),
				phone(B, Skill),
				computer(C, Skill),
				network(D, Skill).	
%skilledPerson(+Name, +List)
%Checks to see whether the person is the person we desire
skilledPerson(Person, [Person|_]).
	
%phone(+Name, +List)
%Checks to see whether person can work the phone 
phone(Value, [H|T]) :- \+skilledPerson(Value,H),
			phone(Value, T).
phone(Value, [H|_]) :- 	skilledPerson(Value, H), 
			phoneSkill(H).

%computer(+Name, +List)
%checks to see whether person can work the computer
computer(Value, [H|T]) :- \+skilledPerson(Value, H),
			  computer(Value, T).
computer(Value, [H|_]) :- skilledPerson(Value, H),
			  computerSkill(H).

%network(+Name, +List)
%checks to see whether person can work the network
network(Value, [H|T]) :- \+skilledPerson(Value, H),
			  network(Value, T).
network(Value, [H|_]) :- skilledPerson(Value, H),
			 networkSkill(H).

%phoneskill(+L)
%Checks whether person has the skill with phones
phoneSkill([_, X|_]) :- X == 1 .

%computerSkill(+L)
%checks whether the person has the skill with computers
computerSkill([_, _, X| _]) :- X == 1 .

%networkSkill(+L)
%checks whether person has the skill with networks
networkSkill([_, _, _, X| _]) :- X == 1 .          
