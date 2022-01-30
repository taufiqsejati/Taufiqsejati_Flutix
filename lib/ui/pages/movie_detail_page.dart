part of 'pages.dart';

class MovieDetailPage extends StatefulWidget {
  final Movie movie;
  final bool isComingSoon;
  MovieDetailPage({this.movie, this.isComingSoon = false});

  @override
  State<MovieDetailPage> createState() => _MovieDetailPageState();
}

class _MovieDetailPageState extends State<MovieDetailPage> {
  bool isComingSoon;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isComingSoon = widget.isComingSoon;
  }

  @override
  Widget build(BuildContext context) {
    MovieDetail movieDetail;
    List<Credit> credits;
    return WillPopScope(
      onWillPop: () async {
        context.bloc<PageBloc>().add(GoToMainPage());

        return;
      },
      child: Scaffold(
        body: Stack(children: [
          Container(
            color: accentColor1,
            child: SafeArea(
              child: Container(
                color: Colors.white,
                child: ListView(children: [
                  FutureBuilder(
                      future: MovieServices.getDetails(widget.movie),
                      builder: (_, snapshot) {
                        if (snapshot.hasData) {
                          movieDetail = snapshot.data;
                        }

                        return Column(
                          children: <Widget>[
                            Stack(
                              children: <Widget>[
                                //NOTE - BACKDROP
                                Stack(
                                  children: <Widget>[
                                    Container(
                                      height: 270,
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                              image: NetworkImage(imageBaseURL +
                                                      "w1280" +
                                                      widget
                                                          .movie.backdropPath ??
                                                  widget.movie.posterPath),
                                              fit: BoxFit.cover)),
                                    ),
                                    Container(
                                      height: 271,
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                              begin: Alignment(0, 1),
                                              end: Alignment(0, 0.06),
                                              colors: [
                                            Colors.white,
                                            Colors.white.withOpacity(0)
                                          ])),
                                    )
                                  ],
                                ),
                                //NOTE - BACK ICON
                                Container(
                                  margin: EdgeInsets.only(
                                      top: 20, left: defaultMargin),
                                  padding: EdgeInsets.all(1),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: Colors.black.withOpacity(0.04)),
                                  child: GestureDetector(
                                    onTap: () {
                                      context
                                          .bloc<PageBloc>()
                                          .add(GoToMainPage());
                                    },
                                    child: Icon(
                                      Icons.arrow_back,
                                      color: Colors.white,
                                    ),
                                  ),
                                )
                              ],
                            ),
                            //NOTE - JUDUL
                            Container(
                              margin: EdgeInsets.fromLTRB(
                                  defaultMargin, 16, defaultMargin, 6),
                              child: Text(
                                widget.movie.title,
                                textAlign: TextAlign.center,
                                style: blackTextFont.copyWith(fontSize: 24),
                              ),
                            ),
                            //NOTE - GENRE
                            (snapshot.hasData)
                                ? Text(
                                    movieDetail.genresAndLanguage,
                                    style: greyTextFont.copyWith(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400),
                                  )
                                : SizedBox(
                                    height: 50,
                                    width: 50,
                                    child: SpinKitFadingCircle(
                                      color: accentColor3,
                                    ),
                                  ),
                            SizedBox(
                              height: 6,
                            ),
                            //NOTE - RATING
                            RatingStars(
                              voteAverage: widget.movie.voteAverage,
                              color: accentColor3,
                              alignment: MainAxisAlignment.center,
                            ),
                            SizedBox(
                              height: 24,
                            ),
                            //NOTE - CREDITS
                            Align(
                              alignment: Alignment.topLeft,
                              child: Container(
                                  margin: EdgeInsets.only(
                                      left: defaultMargin, bottom: 12),
                                  child: Text(
                                    "Cast & Crew",
                                    style: blackTextFont.copyWith(fontSize: 14),
                                  )),
                            ),
                            FutureBuilder(
                                future:
                                    MovieServices.getCredits(widget.movie.id),
                                builder: (_, snapshot) {
                                  if (snapshot.hasData) {
                                    credits = snapshot.data;
                                    return SizedBox(
                                      height: 115,
                                      child: ListView.builder(
                                          scrollDirection: Axis.horizontal,
                                          itemCount: credits.length,
                                          itemBuilder: (_, index) => Container(
                                              margin: EdgeInsets.only(
                                                  left: (index == 0)
                                                      ? defaultMargin
                                                      : 0,
                                                  right: (index ==
                                                          credits.length - 1)
                                                      ? defaultMargin
                                                      : 16),
                                              child:
                                                  CreditCard(credits[index]))),
                                    );
                                  } else {
                                    return SizedBox(
                                        height: 50,
                                        child: SpinKitFadingCircle(
                                          color: accentColor1,
                                        ));
                                  }
                                }),
                            //NOTE - STORYLINE
                            Container(
                              margin: EdgeInsets.fromLTRB(
                                  defaultMargin, 24, defaultMargin, 8),
                              child: Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  "Storyline",
                                  style: blackTextFont,
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.fromLTRB(
                                  defaultMargin, 0, defaultMargin, 30),
                              child: Text(
                                widget.movie.overview,
                                style: greyTextFont.copyWith(
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                            //NOTE - BUTTON
                            RaisedButton(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8)),
                                color: mainColor,
                                child: Text(
                                  "Continue to Book",
                                  style: whiteTextFont.copyWith(fontSize: 16),
                                ),
                                onPressed: () {
                                  var logger = Logger();
                                  if (widget.isComingSoon) {
                                    Flushbar(
                                      duration: Duration(seconds: 4),
                                      flushbarPosition: FlushbarPosition.TOP,
                                      backgroundColor: Color(0xFFFF5C83),
                                      message: "Coming Soon..",
                                    )..show(context);
                                  } else {
                                    context.bloc<PageBloc>().add(
                                        GoToSelectSchedulePage(movieDetail));
                                  }
                                }),
                            SizedBox(height: defaultMargin)
                          ],
                        );
                      }),
                ]),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
