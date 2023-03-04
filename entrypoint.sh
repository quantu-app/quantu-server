#!/bin/bash

/app/bin/rails db:prepare

exec "${@}"