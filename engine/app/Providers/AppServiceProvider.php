<?php

namespace App\Providers;
use Illuminate\Support\ServiceProvider;

class AppServiceProvider extends ServiceProvider
{
    /**
     * Register any application services.
     *
     * @return void
     */
    public function register()
    {

        if ($this->app->runningInConsole()) {
            $this->app->singleton('rabbitmq.consumer', function () {
                $isDownForMaintenance = function () {
                    return $this->app->isDownForMaintenance();
                };

                return new \activecitizen\marketplace\Utils\RabbitMQ\Consumer(
                    $this->app['queue'],
                    $this->app['events'],
                    $this->app[\Illuminate\Contracts\Debug\ExceptionHandler::class],
                    $isDownForMaintenance
                );
            });

        }

    }

    /**
     * Bootstrap any application services.
     *
     * @return void
     */
    public function boot()
    {
        //
    }
}
