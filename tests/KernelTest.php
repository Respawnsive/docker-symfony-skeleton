<?php

namespace App\Tests;

use App\Kernel;
use Doctrine\DBAL\Connection;
use PHPUnit\Exception;
use Symfony\Bundle\FrameworkBundle\Test\KernelTestCase;

class KernelTest extends KernelTestCase
{
    public function testKernelBoot(): void
    {
        // (1) boot the Symfony kernel
        self::bootKernel();

        // (2) use static::getContainer() to access the service container
        $container = static::getContainer();

        $kernel = $container->get(Kernel::class);
        $this->assertTrue($kernel instanceof Kernel);
    }

    public function testDatabase(): void
    {
        // (1) boot the Symfony kernel
        self::bootKernel();

        // (2) use static::getContainer() to access the service container
        $container = static::getContainer();

        /** @var Connection $dbal */
        $dbal = $container->get(Connection::class) ;

        try {
            $dbal->connect() ;
        }
        catch(\Doctrine\DBAL\Exception $ex)
        {
            dump($ex->getMessage());
        }

        $this->assertTrue($dbal->isConnected()) ;
    }



}
