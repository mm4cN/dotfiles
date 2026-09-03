# Context Discipline

The goal of exploration is not repository familiarity. It is uncertainty reduction.

Before reading another file, ask which open question it should answer.

Prefer a chain such as:

1. exact search hit;
2. containing function or module;
3. direct caller or consumer;
4. nearest relevant test;
5. configuration or interface boundary.

Avoid collecting many "possibly useful later" files. They consume context and reduce attention on the actual execution path.
