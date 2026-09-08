# Task 2: Inheritance, polymorphism and composition — HardworkingTrainee,
# AuditTrainee, Cohort

from task1_trainee_lms import Trainee


class HardworkingTrainee(Trainee):
    # "Hardworking" trainee: gets +2 points for homework instead of +1
    def do_homework(self) -> None:
        """Increases score by 2"""
        self.score = self.score + 2


class AuditTrainee(Trainee):
    # "Audit" trainee: always considered passing, regardless of score
    def is_passing(self) -> bool:
        return True


class Cohort:
    title: str
    trainees: list[Trainee]

    def __init__(self, title: str) -> None:
        self.title: str = title
        self.trainees: list[Trainee] = []  # empty by default

    def add_trainee(self, trainee: Trainee) -> None:
        self.trainees.append(trainee)

    def conduct_lecture(self) -> None:
        # Polymorphism: call visit_lecture() on every trainee without
        # knowing its concrete class in advance
        for trainee in self.trainees:
            trainee.visit_lecture()

    def get_passing_students(self) -> list[Trainee]:
        return [trainee for trainee in self.trainees if trainee.is_passing()]


if __name__ == "__main__":
    # Create trainees of different types
    std_trainee = Trainee("Алексей", "Смирнов", score=8, passing_grade=10)
    hard_trainee = HardworkingTrainee("Елена", "Петрова", score=8, passing_grade=10)
    audit_trainee = AuditTrainee("Дмитрий", "Сидоров", score=0, passing_grade=10)

    # Create the cohort and add students
    cohort = Cohort("Python Advanced")
    cohort.add_trainee(std_trainee)
    cohort.add_trainee(hard_trainee)
    cohort.add_trainee(audit_trainee)

    # Conduct a lecture for the whole group (+1 point to everyone)
    cohort.conduct_lecture()

    # Check the overridden homework method for the hardworking trainee (+2 points)
    hard_trainee.do_homework()

    passing_students = cohort.get_passing_students()

    print(f"=== УСПЕВАЕМОСТЬ ГРУППЫ '{cohort.title}' ===")
    for student in cohort.trainees:
        print(f"{student.name} {student.surname} | Баллы: {student.score} | Проходит: {student.is_passing()}")

    print("\nУспешно зачислены на следующий модуль:")
    for student in passing_students:
        print(f"- {student.name} {student.surname}")