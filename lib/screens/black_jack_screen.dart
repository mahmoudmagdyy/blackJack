import 'dart:math';


import 'package:flutter/material.dart';

import '../widgets/cards_grid_view.dart';
import '../widgets/custom_button.dart';

class BlackJackScreen extends StatefulWidget {
  const BlackJackScreen({Key? key}) : super(key: key);

  @override
  State<BlackJackScreen> createState() => _BlackJackScreenState();
}

class _BlackJackScreenState extends State<BlackJackScreen> {
  bool _isGameStarted = false;

  //Card Images
  List<Image> myCards = [];
  List<Image> dealersCards = [];

  //Cards
  String? dealersFirstCard;
  String? dealersSecondCard;
  String? playersFirstCard;
  String? playersSecondCard;

  //Scores
  int dealersScore = 0;
  int playersScore = 0;

  //Deck of Cards
  final Map<String, int> deckOfCards = {
    "assets/cards/2.1.png": 2,
    "assets/cards/2.2.png": 2,
    "assets/cards/2.3.png": 2,
    "assets/cards/2.4.png": 2,
    "assets/cards/3.1.png": 3,
    "assets/cards/3.2.png": 3,
    "assets/cards/3.3.png": 3,
    "assets/cards/3.4.png": 3,
    "assets/cards/4.1.png": 4,
    "assets/cards/4.2.png": 4,
    "assets/cards/4.3.png": 4,
    "assets/cards/4.4.png": 4,
    "assets/cards/5.1.png": 5,
    "assets/cards/5.2.png": 5,
    "assets/cards/5.3.png": 5,
    "assets/cards/5.4.png": 5,
    "assets/cards/6.1.png": 6,
    "assets/cards/6.2.png": 6,
    "assets/cards/6.3.png": 6,
    "assets/cards/6.4.png": 6,
    "assets/cards/7.1.png": 7,
    "assets/cards/7.2.png": 7,
    "assets/cards/7.3.png": 7,
    "assets/cards/7.4.png": 7,
    "assets/cards/8.1.png": 8,
    "assets/cards/8.2.png": 8,
    "assets/cards/8.3.png": 8,
    "assets/cards/8.4.png": 8,
    "assets/cards/9.1.png": 9,
    "assets/cards/9.2.png": 9,
    "assets/cards/9.3.png": 9,
    "assets/cards/9.4.png": 9,
    "assets/cards/10.1.png": 10,
    "assets/cards/10.2.png": 10,
    "assets/cards/10.3.png": 10,
    "assets/cards/10.4.png": 10,
    "assets/cards/J1.png": 10,
    "assets/cards/J2.png": 10,
    "assets/cards/J3.png": 10,
    "assets/cards/J4.png": 10,
    "assets/cards/Q1.png": 10,
    "assets/cards/Q2.png": 10,
    "assets/cards/Q3.png": 10,
    "assets/cards/Q4.png": 10,
    "assets/cards/K1.png": 10,
    "assets/cards/K2.png": 10,
    "assets/cards/K3.png": 10,
    "assets/cards/K4.png": 10,
    "assets/cards/A1.png": 11,
    "assets/cards/A2.png": 11,
    "assets/cards/A3.png": 11,
    "assets/cards/A4.png": 11,
  };

  Map<String, int> playingCards = {};

  @override
  void initState() {
    super.initState();

    playingCards.addAll(deckOfCards);
  }

  //Reset round && cards
  void startNewRound() {
    _isGameStarted = true;

    //Start new round with full deckofcards.
    playingCards = {};
    playingCards.addAll(deckOfCards);

    //reset card images
    myCards = [];
    dealersCards = [];

    //Random card one for dealer
    Random random = Random();
    String cardOneKey =
        playingCards.keys.elementAt(random.nextInt(playingCards.length));
    //Remove used card key from playingCards
    playingCards.removeWhere((key, value) => key == cardOneKey);

    //Random card two for dealer
    String cardTwoKey =
        playingCards.keys.elementAt(random.nextInt(playingCards.length));
    //Remove used card key from playingCards
    playingCards.removeWhere((key, value) => key == cardTwoKey);

    //Random card one for the player
    String cardThreeKey =
        playingCards.keys.elementAt(random.nextInt(playingCards.length));
    playingCards.removeWhere((key, value) => key == cardThreeKey);

    //Random card two for the player
    String cardFourkey =
        playingCards.keys.elementAt(random.nextInt(playingCards.length));
    playingCards.removeWhere((key, value) => key == cardFourkey);

    //Assign card keys to dealer's cards
    dealersFirstCard = cardOneKey;
    dealersSecondCard = cardTwoKey;

    //Assign card keys to player's cards
    playersFirstCard = cardThreeKey;
    playersSecondCard = cardFourkey;

    //Adding dealers card images to display them in Grid View
    dealersCards.add(Image.asset(dealersFirstCard!));
    dealersCards.add(Image.asset(dealersSecondCard!));

    //Score for dealer
    dealersScore =
        deckOfCards[dealersFirstCard]! + deckOfCards[dealersSecondCard]!;

    //Adding player card images to display them in grid view
    myCards.add(Image.asset(playersFirstCard!));
    myCards.add(Image.asset(playersSecondCard!));

    //Calculate score for the player (my score)
    playersScore =
        deckOfCards[playersFirstCard]! + deckOfCards[playersSecondCard]!;
// if dealerScrore two image <14
    if (dealersScore <= 14) {
      String thirdDealersCard =
          playingCards.keys.elementAt(random.nextInt(playingCards.length));
      //playingCards.removeWhere((key, value) => key == thirdDealersCard);
      dealersCards.add(Image.asset(thirdDealersCard));

      dealersScore = dealersScore + deckOfCards[thirdDealersCard]!;
    }

    setState(() {});
  }

//Add extra card to the player
  void addCard() {
    Random random = Random();

    if (playingCards.length > 0) {
      String cardKey =
          playingCards.keys.elementAt(random.nextInt(playingCards.length));

      playingCards.removeWhere((key, value) => key == cardKey);
      myCards.add(Image.asset(cardKey));

      playersScore = playersScore + deckOfCards[cardKey]!;
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isGameStarted
          ? SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      Text(
                        "Dealer's Score: $dealersScore",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.green[900]),
                      ),
                      CardsGridView(cards: dealersCards),
                    ],
                  ),
                  Column(
                    children: [
                      Text("Players Score: $playersScore",
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color:  Colors.green[900]
                       )),
                      CardsGridView(cards: myCards)
                    ],
                  ),



                  IntrinsicWidth(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        CustomButton(
                          onPressed: () {

                           if(playersScore>dealersScore&& playersScore<=21){
                             buildShowGeneralDialog(context,"Player Is Win");


                            }else{
                              buildShowGeneralDialog(context,"Dearler Is Win");
                            }

                          },
                          label: "Show Result",
                        ),
                        CustomButton(
                          onPressed: () {
                            setState(() {
                              if (playersScore<=21)
                            {
                              addCard();
                            }else if(playersScore>dealersScore&& playersScore<=21){
                              buildShowGeneralDialog(context,"Player Is Win");


                            }else{
                              buildShowGeneralDialog(context,"Dearler Is Win");
                            }});




                          },
                          label: "Another Card",
                        ),
                        CustomButton(
                          onPressed: () {
                            startNewRound();
                          },
                          label: "Next Round",
                        ),
                      ],
                    ),
                  ),

                ],
              ),
            )
          : Center(
              child: CustomButton(
                onPressed: () => startNewRound(),
                label: "Start Game",
              ),
            ),
    );
  }

  Future<Object?> buildShowGeneralDialog(BuildContext context,text) {
    return showGeneralDialog(
                                context: context,
                                barrierDismissible: true,
                                barrierLabel:
                                MaterialLocalizations.of(context).modalBarrierDismissLabel,
                                barrierColor: Colors.black45,
                                transitionDuration: const Duration(milliseconds: 200),
                                pageBuilder: (BuildContext buildContext, Animation animation,
                                    Animation secondaryAnimation) {
                                  return Center(
                                    child: SizedBox(
                                      height: 300,
                                      width: 300,
                                      child: Card(
                                        elevation: 3,
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          children:  [
                                            Text( text,
                                              style: TextStyle(fontWeight: FontWeight.bold),
                                            ),

                                            CustomButton(
                                              onPressed: () {
                                            startNewRound();
                                            Navigator.of(context).pop();
                                            },

                                              label: "Close",
                                            ),

                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                });
  }
}
