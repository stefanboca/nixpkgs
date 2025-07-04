{
  stdenv,
  lib,
  fetchFromGitHub,
  autoreconfHook,
}:

stdenv.mkDerivation rec {
  pname = "duti";
  version = "1.5.5pre";
  src = fetchFromGitHub {
    owner = "moretension";
    repo = "duti";
    rev = "fe3d3dc411bcea6af7a8cbe53c0e08ed5ecacdb2";
    sha256 = "1pg4i6ghpib2gy1sqpml7dbnhr1vbr43fs2pqkd09i4w3nmgpic9";
  };

  patches = [
    ./buildConfigure.patch
  ];

  nativeBuildInputs = [ autoreconfHook ];

  meta = with lib; {
    description = "Command-line tool to select default applications for document types and URL schemes on Mac OS X";
    longDescription = ''
      duti is a command-line utility capable of setting default applications for
      various document types on Mac OS X, using Apple's Uniform Type Identifiers. A
      UTI is a unique string describing the format of a file's content. For instance,
      a Microsoft Word document has a UTI of com.microsoft.word.doc. Using duti, the
      user can change which application acts as the default handler for a given UTI.
    '';
    maintainers = with maintainers; [
      matthewbauer
      n-hass
    ];
    platforms = platforms.darwin;
    license = licenses.publicDomain;
    homepage = "https://github.com/moretension/duti/";
  };
}
