{
  cacert,
  fetchFromGitHub,
  lib,
  rustPlatform,
  stdenv,
  versionCheckHook,
}:
rustPlatform.buildRustPackage (finalAttrs: {
  pname = "kache";
  version = "0.19.0";
  __structuredAttrs = true;

  src = fetchFromGitHub {
    owner = "kunobi-ninja";
    repo = "kache";
    tag = "v${finalAttrs.version}";
    hash = "sha256-gr104RTXjLo4WKnxElba1WrtrBEYD07+44RPQCGEjKk=";
  };

  cargoHash = "sha256-6gJ9PwDGivybIygjGHP+G6f6d1bs7ukTOr59Oq2j6e4=";

  cargoBuildFlags = [
    "-p"
    "kache"
  ];
  cargoTestFlags = [
    "-p"
    "kache"
    "--bins" # exclude integration tests
  ];

  # The tmutil xattr test shells out to /usr/bin/tmutil which isn't in the sandbox.
  checkFlags = lib.optional stdenv.hostPlatform.isDarwin "--skip=store::tests::test_exclude_from_indexing_sets_tmutil_xattr";

  __darwinAllowLocalNetworking = true;
  nativeCheckInputs = [ cacert ];
  nativeInstallCheckInputs = [ versionCheckHook ];
  doInstallCheck = true;

  meta = {
    description = "Zero-copy, content-addressed build cache for Rust, C/C++ and more";
    homepage = "https://github.com/kunobi-ninja/kache";
    license = lib.licenses.asl20;
    mainProgram = "kache";
    maintainers = with lib.maintainers; [ stefanboca ];
  };
})
