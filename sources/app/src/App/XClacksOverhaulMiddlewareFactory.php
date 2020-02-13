<?php

declare(strict_types=1);

namespace App;

use Psr\Container\ContainerInterface;

class XClacksOverhaulMiddlewareFactory
{
    public function __invoke(ContainerInterface $container) : XClacksOverhaulMiddleware
    {
        return new XClacksOverhaulMiddleware();
    }
}
