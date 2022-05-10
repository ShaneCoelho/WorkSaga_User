// import 'dart:async';

// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';

// class MappageWidget extends StatefulWidget {


//   @override
//   _MappageWidgetState createState() => _MappageWidgetState();
// }

// class _MappageWidgetState extends State<MappageWidget> {
//   late LatLng googleMapsCenter;
//   late Completer<GoogleMapController> googleMapsController;
//   late TextEditingController textController;
//   final scaffoldKey = GlobalKey<ScaffoldState>();

//   @override
//   void initState() {
//     super.initState();
//     textController = TextEditingController();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       key: scaffoldKey,
//       resizeToAvoidBottomInset: false,
//       backgroundColor: Color(0xFFEFEFEF),
//       body: Column(
//         mainAxisSize: MainAxisSize.max,
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Expanded(
//             child: Stack(
//               alignment: AlignmentDirectional(-0.25, 1),
//               children: [
//                 Align(
//                   alignment: AlignmentDirectional(0, 0),
//                   child: Container(
//                     height: MediaQuery.of(context).size.height * 1,
//                     decoration: BoxDecoration(),
//                     child: FlutterFlowGoogleMap(
//                       controller: googleMapsController,
//                       onCameraIdle: (latLng) => googleMapsCenter = latLng,
//                       initialLocation: googleMapsCenter ??=
//                           LatLng(13.106061, -59.613158),
//                       markerColor: GoogleMarkerColor.blue,
//                       mapType: MapType.normal,
//                       style: GoogleMapStyle.aubergine,
//                       initialZoom: 14,
//                       allowInteraction: true,
//                       allowZoom: true,
//                       showZoomControls: true,
//                       showLocation: true,
//                       showCompass: false,
//                       showMapToolbar: false,
//                       showTraffic: false,
//                       centerMapOnMarkerTap: true,
//                     ),
//                   ),
//                 ),
//                 Container(
//                   width: MediaQuery.of(context).size.width,
//                   height: 250,
//                   decoration: BoxDecoration(
//                     color: Color(0xFFCBDEED),
//                     borderRadius: BorderRadius.only(
//                       bottomLeft: Radius.circular(0),
//                       bottomRight: Radius.circular(0),
//                       topLeft: Radius.circular(30),
//                       topRight: Radius.circular(30),
//                     ),
//                   ),
//                   child: Column(
//                     mainAxisSize: MainAxisSize.max,
//                     children: [
//                       Padding(
//                         padding: EdgeInsetsDirectional.fromSTEB(0, 30, 0, 0),
//                         child: Row(
//                           mainAxisSize: MainAxisSize.max,
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Padding(
//                               padding:
//                                   EdgeInsetsDirectional.fromSTEB(0, 1, 1, 1),
//                               child: ElevatedButton(
//                                 onPressed: () {
//                                   print('Button pressed ...');
//                                 },
//                                 text: 'Use Current Location',
//                                 icon: Icon(
//                                   Icons.gps_fixed,
//                                   size: 15,
//                                 ),
//                                 options: FFButtonOptions(
//                                   width: 250,
//                                   height: 40,
//                                   color: Color(0xFF182A42),
//                                   textStyle: FlutterFlowTheme.of(context)
//                                       .subtitle2
//                                       .override(
//                                         fontFamily: 'Poppins',
//                                         color: Colors.white,
//                                       ),
//                                   borderSide: BorderSide(
//                                     color: Colors.transparent,
//                                     width: 1,
//                                   ),
//                                   borderRadius: 20,
//                                 ), child: null,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                       Padding(
//                         padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
//                         child: Row(
//                           mainAxisSize: MainAxisSize.max,
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Padding(
//                               padding:
//                                   EdgeInsetsDirectional.fromSTEB(0, 16, 0, 0),
//                               child: Material(
//                                 color: Colors.transparent,
//                                 elevation: 0,
//                                 shape: RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(30),
//                                 ),
//                                 child: Container(
//                                   width:
//                                       MediaQuery.of(context).size.width * 0.9,
//                                   height: 50,
//                                   decoration: BoxDecoration(
//                                     color: Color(0xFFCBDEED),
//                                     boxShadow: [
//                                       BoxShadow(
//                                         blurRadius: 0,
//                                         color: Color(0x4E000000),
//                                         offset: Offset(0, 0),
//                                       )
//                                     ],
//                                     borderRadius: BorderRadius.circular(30),
//                                     border: Border.all(
//                                       color: Color(0xFF182A42),
//                                       width: 2,
//                                     ),
//                                   ),
//                                   child: Column(
//                                     mainAxisSize: MainAxisSize.max,
//                                     children: [
//                                       Padding(
//                                         padding: EdgeInsetsDirectional.fromSTEB(
//                                             8, 0, 8, 0),
//                                         child: Row(
//                                           mainAxisSize: MainAxisSize.max,
//                                           children: [
//                                             Padding(
//                                               padding: EdgeInsetsDirectional
//                                                   .fromSTEB(4, 0, 4, 0),
//                                               child: Icon(
//                                                 Icons.search_rounded,
//                                                 color: Color(0xFF182A42),
//                                                 size: 24,
//                                               ),
//                                             ),
//                                             Expanded(
//                                               child: Padding(
//                                                 padding: EdgeInsetsDirectional
//                                                     .fromSTEB(4, 0, 0, 0),
//                                                 child: TextFormField(
//                                                   controller: textController,
//                                                   obscureText: false,
//                                                   decoration: InputDecoration(
//                                                     labelText:
//                                                         widget.searchText,
//                                                     enabledBorder:
//                                                         UnderlineInputBorder(
//                                                       borderSide: BorderSide(
//                                                         color:
//                                                             Color(0x00000000),
//                                                         width: 1,
//                                                       ),
//                                                       borderRadius:
//                                                           const BorderRadius
//                                                               .only(
//                                                         topLeft:
//                                                             Radius.circular(
//                                                                 4.0),
//                                                         topRight:
//                                                             Radius.circular(
//                                                                 4.0),
//                                                       ),
//                                                     ),
//                                                     focusedBorder:
//                                                         UnderlineInputBorder(
//                                                       borderSide: BorderSide(
//                                                         color:
//                                                             Color(0x00000000),
//                                                         width: 1,
//                                                       ),
//                                                       borderRadius:
//                                                           const BorderRadius
//                                                               .only(
//                                                         topLeft:
//                                                             Radius.circular(
//                                                                 4.0),
//                                                         topRight:
//                                                             Radius.circular(
//                                                                 4.0),
//                                                       ),
//                                                     ),
//                                                   ),
//                                                   style: FlutterFlowTheme.of(
//                                                           context)
//                                                       .bodyText1
//                                                       .override(
//                                                         fontFamily:
//                                                             'Lexend Deca',
//                                                         color:
//                                                             Color(0xFF95A1AC),
//                                                         fontSize: 14,
//                                                         fontWeight:
//                                                             FontWeight.normal,
//                                                       ),
//                                                 ),
//                                               ),
//                                             ),
//                                           ],
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
