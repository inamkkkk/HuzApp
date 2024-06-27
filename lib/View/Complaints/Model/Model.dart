class complaintcounts {
  int? open;
  int? inProgress;
  int? solved;
  int? close;

  complaintcounts({this.open, this.inProgress, this.solved, this.close});

  complaintcounts.fromJson(Map<String, dynamic> json) {
    open = json['Open'];
    inProgress = json['InProgress'];
    solved = json['Solved'];
    close = json['Close'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Open'] = this.open;
    data['InProgress'] = this.inProgress;
    data['Solved'] = this.solved;
    data['Close'] = this.close;
    return data;
  }
}