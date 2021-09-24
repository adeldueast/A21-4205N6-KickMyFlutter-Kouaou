class Task {
  final String nom;
  final double pourcentageTask;
  final double pourcentageDate;
  final DateTime dateLimite;


  const Task(this.nom, this.pourcentageTask, this.pourcentageDate,
      this.dateLimite);

  @override
  String toString() {
    return 'Task: {name: $nom, pourcentageTask: $pourcentageTask pourcentage: $pourcentageTask dateLimite : $dateLimite';
  }
}