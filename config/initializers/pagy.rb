# Pagy initializer
# See https://ddnexus.github.io/pagy/api/pagy

Pagy::DEFAULT[:limit] = 10 # For the purposes of this project, a lower limit is needed to show the pagination headers

require "pagy/extras/headers"
require "pagy/extras/overflow"

Pagy::DEFAULT[:overflow] = :last_page
