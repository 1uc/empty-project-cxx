#include "catch/catch.hpp"

TEST_CASE("Simple assert.") { REQUIRE(1 == 1); }

TEST_CASE("Use after free.", "[.][use-after-free]") {
  double *p = (double *)malloc(10 * sizeof(double));
  free(p);
  REQUIRE(p[4] == 42);
}

TEST_CASE("Out-of-bounds access.", "[.][out-of-bounds]") {
  double p[] = {42, 42, 42, 42};
  REQUIRE(p[4] == 42);
}
