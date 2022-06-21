import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"
import custom_functions from '../src/function_example'

import '../stylesheets/application.scss'

Rails.start();
Turbolinks.start();
ActiveStorage.start();

custom_functions.function_example();
