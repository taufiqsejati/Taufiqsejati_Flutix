part of 'pages.dart';

// ignore: must_be_immutable
class SelectSchedulePage extends StatefulWidget {
  MovieDetail movieDetail;
  SelectSchedulePage(this.movieDetail);

  @override
  _SelectSchedulePageState createState() => _SelectSchedulePageState();
}

class _SelectSchedulePageState extends State<SelectSchedulePage> {
  List<DateTime> dates;
  DateTime selectDate;
  int selectedTime;
  Theater selectedTheater;
  bool isValid = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    dates =
        List.generate(7, (index) => DateTime.now().add(Duration(days: index)));
    selectDate = dates[0];
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        context
            .bloc<PageBloc>()
            .add(GoToMovieDetailPage(movie: widget.movieDetail));

        return;
      },
      child: Scaffold(
          body: Stack(
        children: [
          Container(
            color: accentColor1,
          ),
          SafeArea(
              child: Container(
            color: Colors.white,
          )),
          ListView(children: [
            //NOTE - BACK BUTTON
            Row(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 20, left: defaultMargin),
                  padding: EdgeInsets.all(1),
                  child: GestureDetector(
                    onTap: () {
                      context
                          .bloc<PageBloc>()
                          .add(GoToMovieDetailPage(movie: widget.movieDetail));
                    },
                    child: Icon(
                      Icons.arrow_back,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
            //NOTE - CHOOSE DATE
            Container(
                margin:
                    EdgeInsets.fromLTRB(defaultMargin, 20, defaultMargin, 16),
                child: Text('Choose Date',
                    style: blackTextFont.copyWith(fontSize: 20))),
            Container(
                margin: EdgeInsets.only(bottom: 24),
                height: 90,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: dates.length,
                    itemBuilder: (_, index) => Container(
                          margin: EdgeInsets.only(
                              left: (index == 0) ? defaultMargin : 0,
                              right: (index < dates.length - 1)
                                  ? 16
                                  : defaultMargin),
                          child: DateCard(
                            dates[index],
                            isSelected: selectDate == dates[index],
                            onTap: () {
                              setState(() {
                                selectDate = dates[index];
                              });
                            },
                          ),
                        ))),
            //NOTE - CHOOSE TIME
            generateTimeTable(),
            //NOTE - NEXT BUTTON
            SizedBox(height: 10),
            Align(
              alignment: Alignment.topCenter,
              child: BlocBuilder<UserBloc, UserState>(
                builder: (_, userState) => FloatingActionButton(
                    onPressed: () {
                      var logger = Logger();

                      logger.d(
                          "Logger is working!",
                          imageBaseURL +
                              'w154' +
                              widget.movieDetail.posterPath);

                      if (isValid) {
                        context.bloc<PageBloc>().add(GoToSelectSeatPage(Ticket(
                            widget.movieDetail,
                            selectedTheater,
                            DateTime(selectDate.year, selectDate.month,
                                selectDate.day, selectedTime),
                            randomAlphaNumeric(12).toUpperCase(),
                            null,
                            (userState as UserLoaded).user.name,
                            null)));
                      }
                    },
                    elevation: 0,
                    backgroundColor: (isValid) ? mainColor : Color(0xffE4E4E4),
                    child: Icon(
                      Icons.arrow_forward,
                      color: isValid ? Colors.white : Color(0xffBEBEBE),
                    )),
              ),
            )
          ])
        ],
      )),
    );
  }

  Column generateTimeTable() {
    List<int> schedule = List.generate(7, (index) => 10 + index * 2);
    List<Widget> widgets = [];

    for (var theater in dummyTheaters) {
      widgets.add(Container(
          margin: EdgeInsets.fromLTRB(defaultMargin, 0, defaultMargin, 16),
          child:
              Text(theater.name, style: blackTextFont.copyWith(fontSize: 20))));

      widgets.add(Container(
        height: 50,
        margin: EdgeInsets.only(bottom: 20),
        child: ListView.builder(
          itemCount: schedule.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (_, index) => Container(
            margin: EdgeInsets.only(
                left: (index == 0) ? defaultMargin : 0,
                right: (index < schedule.length - 1) ? 16 : defaultMargin),
            child: SelectableBox("${schedule[index]}:00",
                height: 50,
                isSelected: selectedTheater == theater &&
                    selectedTime == schedule[index],
                isEnabled: schedule[index] > DateTime.now().hour ||
                    selectDate.day != DateTime.now().day, onTap: () {
              setState(() {
                selectedTheater = theater;
                selectedTime = schedule[index];
                // isValid = true;
                if (schedule[index] > DateTime.now().hour ||
                    selectDate.day != DateTime.now().day) {
                  isValid = true;
                } else if (schedule[index] < DateTime.now().hour ||
                    selectDate.day == DateTime.now().day) {
                  isValid = false;
                }
              });
            }),
          ),
        ),
      ));
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: widgets,
    );
  }
}
